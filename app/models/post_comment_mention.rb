class PostCommentMention < ApplicationRecord
  belongs_to :person, touch: true
  belongs_to :post_comment, touch: true
end
