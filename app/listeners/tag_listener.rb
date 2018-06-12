class TagListener
    def self.post_created(user, post)
        tags = post.body.scan(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i)
        if !tags.empty?
            tags.each do |tag|
                new_tag = Tag.where(name: tag, product_id: user.product.id).first_or_create
                if new_tag.valid?
                    post_tag = PostTag.create(tag_id: new_tag.id, post_id: post.id)
                    if !post_tag.valid?
                        logger.error("Failed to save PostTag join with Post ID: #{post.id} and Tag ID: #{new_tag.id}")
                    end
                else
                    logger.error("Failed to save tag with Name: #{tag}")
                end
            end
        end
    end
end