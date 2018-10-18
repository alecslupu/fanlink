#
# Wrappers for interfacing with AWS.
#
module Flaws
  #
  # The presets we use. The `SIZER` preset (1080p MP4) can be used to
  # kludge out the input video's size (or at least as much of its size
  # as we care about).
  #

  def self.transcoding_queue?
    !!queue_url
  end

  def self.start_transcoding(filename, data)
    filename = filename.gsub(/^\//, "")
    to_output  = outputter_for(filename)
    transcoder = Aws::ElasticTranscoder::Client.new(
      access_key_id: key,
      secret_access_key: secret
    )

    transcoder.create_job(
      pipeline_id: pipeline_id,
      input: { key: filename },
      outputs: [ SIZER ].map(&to_output),
      user_metadata: data.merge('sizer': "t"),
    ).job
  end

  #
  # Find a message in SQS. If we find what you're looking for, we will
  # remove it from the queue before we return it to you.
  #
  # We currently only use SQS for dev and test video transcoding so we
  # make some assumptions and our usage is a bit slapdash (and that's
  # okay).
  #
  # Just because you didn't find what you were looking for doesn't mean
  # that it isn't really there or won't be there soon. SQS's behavior
  # with low cardinality queues is a bit odd so you should try again in
  # 30s or so if you didn't find what you wanted.
  #
  # @param &block
  #   Pass a block to select the message you want, the block gets the
  #   message's inner SNS-JSON and should return `true` if it finds
  #   the one it wants.
  # @return [Hash]
  #   The message you wanted or `nil` if it wasn't there.
  # @raises [Aws::SQS::Errors::ServiceError]
  #   The raw exception (if any) from the transcoder.
  #
  def self.extract_from_transcoding_queue(&block)
    unpack  = lambda { |m| { rh: m.receipt_handle, body: JSON.parse(JSON.parse(m.body)["Message"]) } }
    the_one = lambda { |m| block[m[:body]] }
    sqs     = Aws::SQS::Client.new(access_key_id: key, secret_access_key: secret)
    if (msg = sqs.receive_message(queue_url: queue_url, max_number_of_messages: 10).messages.map(&unpack).find(&the_one))
      sqs.delete_message(queue_url: queue_url, receipt_handle: msg[:rh])
      msg = msg[:body]
    end
    msg
  end

  private

    VIDEO_PRESETS = [
      { id: "1351620000001-000001", mime: "video/mp4",             name: "v-1080p.mp4",  w: 1920, h: 1080 },
      { id: "1351620000001-000010", mime: "video/mp4",             name: "v-720p.mp4",   w: 1280, h: 720 },
      { id: "1351620000001-000020", mime: "video/mp4",             name: "v.mp4",        w: 854, h: 480, always: true },
      { id: "1351620000001-000040", mime: "video/mp4",             name: "v-360p.mp4",   w: 640, h: 320, always: true },
      { id: "1351620000001-000061", mime: "video/mp4",             name: "v-240p.mp4",   w: 320, h: 240, always: true },
      { id: "1351620000001-200010", mime: "application/x-mpegurl", name: "v-hls20M",     w: 1024, h: 768, playlist: true },
      { id: "1351620000001-200020", mime: "application/x-mpegurl", name: "v-hls15M",     w: 960, h: 640, playlist: true },
      { id: "1351620000001-200030", mime: "application/x-mpegurl", name: "v-hls10M",     w: 640, h: 432, playlist: true },
      { id: "1351620000001-200040", mime: "application/x-mpegurl", name: "v-hls600k",    w: 480, h: 320, playlist: true },
      { id: "1351620000001-200050", mime: "application/x-mpegurl", name: "v-hls400k",    w: 400, h: 288, always: true, playlist: true },
    ]
    SIZER = VIDEO_PRESETS.first

    def self.output_name_for(filename)
      basename = File.basename(filename, File.extname(filename))
      dirname = File.dirname(filename).gsub("original", "transcoded")
      ->(p) { "#{dirname}/#{basename}-#{p[:name]}" }
    end

    def self.outputter_for(filename)
      output_name = output_name_for(filename)
      ->(p) { { key: output_name[p], preset_id: p[:id] }.merge(p[:playlist] ? { segment_duration: "10" } : {}) }
    end

    def self.key
      Rails.configuration.fanlink[:aws][:transcoder_key]
    end

    def self.secret
      Rails.configuration.fanlink[:aws][:transcoder_secret]
    end

    def self.pipeline_id
      Rails.configuration.fanlink[:aws][:transcoder_pipeline_id]
    end
    j
    def self.queue_url
      Rails.configuration.fanlink[:aws][:transcoder_queue_url]
    end
end
