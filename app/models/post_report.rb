class PostReport < ApplicationRecord
  enum status: %i[ pending no_action_needed post_hidden ]

  belongs_to :post
  belongs_to :person

  has_paper_trail

  validates :reason, length: { maximum: 500 }
  def create_time
    created_at.to_s
  end
end
