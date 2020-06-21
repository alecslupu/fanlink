# frozen_string_literal: true
#
# Wrappers for interfacing with AWS.
#
module Flaws
  #
  # The presets we use. The `SIZER` preset (1080p MP4) can be used to
  # kludge out the input video's size (or at least as much of its size
  # as we care about).
  #
  VIDEO_PRESETS = [
    { id: "1542983455511-yqngpd", mime: "video/mp4", name: "v-1080p.mp4", w: 1920, h: 1080, thumbnails: true },
    { id: "1351620000001-000010", mime: "video/mp4", name: "v-720p.mp4", w: 1280, h: 720 },
    { id: "1351620000001-000020", mime: "video/mp4", name: "v.mp4", w: 854, h: 480, always: true },
    { id: "1351620000001-000040", mime: "video/mp4", name: "v-360p.mp4", w: 640, h: 320, always: true },
    { id: "1351620000001-000061", mime: "video/mp4", name: "v-240p.mp4", w: 320, h: 240, always: true },
    # We are not using streaming just yet
    # {id: "1351620000001-200010", mime: "application/x-mpegurl", name: "v-hls20M", w: 1024, h: 768, playlist: true},
    # {id: "1351620000001-200020", mime: "application/x-mpegurl", name: "v-hls15M", w: 960, h: 640, playlist: true},
    # {id: "1351620000001-200030", mime: "application/x-mpegurl", name: "v-hls10M", w: 640, h: 432, playlist: true},
    # {id: "1351620000001-200040", mime: "application/x-mpegurl", name: "v-hls600k", w: 480, h: 320, playlist: true},
    # {id: "1351620000001-200050", mime: "application/x-mpegurl", name: "v-hls400k", w: 400, h: 288, always: true, playlist: true},
  ]
  SIZER = VIDEO_PRESETS.first

  #
  # Confirm an SNS subscription.
  #
  # @param [String] topic_arn
  #   The SNS topic in question.
  # @param [String] token
  #   The token you got with the subscription-confirmation message.
  # @raises [ArgumentError]
  #   If `token` is missing.
  # @raises [Aws::SNS::Errors::ServiceError]
  #   If AWS doesn't like the token.
  #
  def self.sns_confirm(topic_arn, token)
    raise ArgumentError.new("Missing token for subscription confirmation") if (token.blank?)
    sns_client.confirm_subscription(topic_arn: topic_arn, token: token)
  end

  def self.sns_client
    Aws::SNS::Client.new(access_key_id: key, secret_access_key: secret, region: region)
  end

  def self.sqs_client
    Aws::SQS::Client.new(access_key_id: key, secret_access_key: secret, region: region)
  end

  def self.s3_client
    Aws::S3::Client.new(access_key_id: key, secret_access_key: secret, region: region)
  end

  def self.transcoder_client
    Aws::ElasticTranscoder::Client.new(
      access_key_id: key,
      secret_access_key: secret,
      region: region
    )
  end

  def self.transcoding_queue?
    !!queue_url
  end

  def self.start_transcoding(filename, data)
    filename = filename.gsub(/^\//, "")
    to_output = outputter_for(filename)

    transcoder_client.create_job(
      pipeline_id: pipeline_id,
      input: { key: filename },
      outputs: [SIZER].map(&to_output),
      user_metadata: data.merge('sizer': "t"),
    ).job
  end

  def self.finish_transcoding(filename, width, height, data)
    the_sizer = lambda { |p| p[:id] == SIZER[:id] }
    the_ones_that_fit = lambda { |p| p[:always] || (p[:w] <= width && p[:h] <= height) }
    presets = VIDEO_PRESETS.reject(&the_sizer).select(&the_ones_that_fit)
    filename = filename.gsub(/^\//, "")
    to_output = outputter_for(filename)
    playlists = lambda { |p| p[:playlist] }
    to_output_name = output_name_for(filename)

    if (width < SIZER[:w] && height < SIZER[:h])
      s3_client.delete_object(bucket: bucket,  key: to_output_name[SIZER])
    else
      data = data.merge("presets" => SIZER[:id])
    end

    transcoder_client.create_job(
      pipeline_id: pipeline_id,
      input: { key: filename },
      outputs: presets.map(&to_output),
      #:playlists => [{
      #  :name => "#{video_directory_for(filename)}/v",
      #  :format => "HLSv3",
      #  :output_keys => presets.select(&playlists).map(&to_output_name),
      # }],
      user_metadata: data,
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
    unpack = lambda { |m| { rh: m.receipt_handle, body: JSON.parse(JSON.parse(m.body)["Message"]) } }
    the_one = lambda { |m| block[m[:body]] }
    sqs = sqs_client
    if (msg = sqs.receive_message(queue_url: queue_url, max_number_of_messages: 10).messages.map(&unpack).find(&the_one))
      sqs.delete_message(queue_url: queue_url, receipt_handle: msg[:rh])
      msg = msg[:body]
    end
    msg
  end

  #
  # Return the MIME type and source summary for `filename`.
  #
  # @param [String] filename
  #   The name of the original uploaded file.
  # @param [Array<String>] preset_ids
  #   The presets that were used.
  # @return [Array<Hash>]
  #   Array of hashes with `:type` and `:src` keys. The `:type` is the
  #   MIME type, the `:src` is the URL for the video.
  #
  def self.transcoded_summary_for(filename, preset_ids)
    # directory = video_directory_for(filename)
    basename = File.basename(filename, File.extname(filename))

    presets = VIDEO_PRESETS.select { |p| preset_ids.include?(p[:id]) }
    # hls_entry = [{:type => "application/x-mpegurl", :src => "#{hls_server}videos/#{directory}/v.m3u8"}]
    # hls_entry = [] if (presets.all? { |p| !p[:playlist] })

    non_hls = lambda { |p| !p[:playlist] }
    to_summary = lambda { |p| { type: p[:mime], src: "#{s3_server}/#{basename}-#{p[:name]}" } }
    # hls_entry + presets.select(&non_hls).map(&to_summary)
    presets.select(&non_hls).map(&to_summary)
  end

  private

  def self.output_name_for(filename)
    basename = File.basename(filename, File.extname(filename))
    # dirname = video_directory_for(filename)
    -> (p) { "#{basename}-#{p[:name]}" }
  end

  def self.thumbnail_name_for(filename)
    basename = File.basename(filename, File.extname(filename))
    -> (p) { "thumbnails/#{basename}" }
  end

  def self.outputter_for(filename)
    output_name = output_name_for(filename)
    thumbnail_name = thumbnail_name_for(filename)
    -> (p) {
      { key: output_name[p], preset_id: p[:id] }.merge(
        p[:thumbnails] ? { thumbnail_pattern: "#{thumbnail_name[p]}-{count}" } : {}).merge(
          p[:playlist] ? { segment_duration: "10" } : {})
    }
  end

  def self.video_directory_for(filename)
    File.dirname(filename).gsub("original", "transcoded")
  end

  def self.region
    Rails.configuration.fanlink[:aws][:region]
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

  def self.queue_url
    Rails.configuration.fanlink[:aws][:transcoder_queue_url]
  end

  #
  # Return the server we use for serving up HLS files. This will include
  # the trailing slash.
  #
  # @return [String]
  #   The server with leading scheme and a trailing slash.
  #
  def self.hls_server
    Rails.configuration.fanlink[:aws][:hls_server]
  end

  #
  # Return the server we use for serving up RTMP streams. This will
  # include the trailing slash.
  #
  # @return [String]
  #   The server with leading scheme and a trailing slash.
  #
  def self.rtmp_server
    Rails.configuration.fanlink[:aws][:rtmp_server]
  end

  #
  # Return the S3 server.
  #
  # @return [String]
  #   The S3 server with leading schema without the trailing slash.
  #
  def self.s3_server
    "https://s3.amazonaws.com/#{bucket}"
  end

  def self.bucket
    Rails.configuration.fanlink[:aws][:s3_bucket]
  end
end
