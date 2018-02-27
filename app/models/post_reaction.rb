class PostReaction < ApplicationRecord

  belongs_to :post
  belongs_to :person

  has_paper_trail

  validates :reaction, presence: { message: "Reaction is required." }
end
