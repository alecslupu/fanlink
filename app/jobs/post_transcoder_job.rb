class PostTranscoderJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    job = Flaws.start_transcoding(post.video.path, post_id: post.id.to_s)
    post.video_job_id = job.id
    post.save
    post.start_listener
  end
end
