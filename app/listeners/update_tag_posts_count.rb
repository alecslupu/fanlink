# frozen_string_literal: true

class UpdateTagPostsCount
  def self.create_post_tag_successful(pt)
    self.update_post_count(pt)
  end

  def self.update_post_tag_successful(pt)
    self.update_post_count(pt)
  end

private
  def self.update_post_count(pt)
    tag = Tag.find(pt.tag_id)
    if tag
      tag.update_attribute(:posts_count, Post.visible.joins(:tags).where("post_tags.tag_id = ? ", tag.id).count)
    end
  end
end
