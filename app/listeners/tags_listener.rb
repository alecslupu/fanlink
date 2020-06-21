# frozen_string_literal: true

class TagsListener
  def self.post_created(user, post, api_version = 0)
    return unless post.body.present?
    tags = post.body.scan(/\B#(\p{Word}+)\w*/i)
    unless tags.empty?
      post.tag_list.add(tags)
      post.save
    end
  end
end
