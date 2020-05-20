# frozen_string_literal: true
class TagsListener
  def self.post_created(user, post, api_version = 0)
    if post.body.present?
      tags = post.body.scan(/\B#(\p{Word}+)\w*/i)
      if !tags.empty?
        tags.each do |tag|
          new_tag = Tag.where(name: tag, product_id: user.product.id).first_or_create
          if new_tag.valid?
            post_tag = PostTag.create(tag_id: new_tag.id, post_id: post.id)
            if post_tag.valid?
              new_tag.update_attribute(:posts_count, new_tag.posts_count + 1)
            else
              Rails.logger.error("Failed to save PostTag join with Post ID: #{post.id} and Tag ID: #{new_tag.id}")
            end
          else
            Rails.logger.error("Failed to save tag with Name: #{tag}")
          end
        end
      end
    end
  end
end
