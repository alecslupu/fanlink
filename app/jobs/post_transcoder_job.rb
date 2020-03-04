class PostTranscoderJob < Struct.new(:post_id)
  def perform
    post = Post.find(post_id)
    job = Flaws.start_transcoding(post.video.path, post_id: post.id.to_s)
    post.video_job_id = job.id
    post.save
    post.start_listener()
  end

  def queue_name
    :default
  end
end
