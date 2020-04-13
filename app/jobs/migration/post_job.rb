module Migration
  class PostJob < ApplicationJob
    queue_as :migration

    def perform(post_id)
      langs = ["en", "es", "ro"]
      post = Post.find(post_id)
      langs.each do |value|
        next if post.untranslated_body[value].nil?
        next if post.untranslated_body[value] == '-'
        I18n.locale = value
        post.body = post.untranslated_body[value]
        post.save rescue nil
      end
      unless Post.with_translations('en').where(id: post.id).first.present?
        next if post.untranslated_body["un"].nil?
        next if post.untranslated_body["un"].empty?
        I18n.locale = "en"
        post.body = post.untranslated_body["un"]
        post.save rescue nil
      end
    end
  end
end
