class MessageReport < ApplicationRecord

  enum status: %i[ pending no_action_needed message_hidden ]

  belongs_to :message
  belongs_to :person

  has_paper_trail

  def create_time
    created_at.to_s
  end
end
