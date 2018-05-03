class PostCommentMention < ApplicationRecord

  belongs_to :person
  belongs_to :post_comment

end
