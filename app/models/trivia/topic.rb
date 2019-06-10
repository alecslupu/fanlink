# == Schema Information
#
# Table name: trivia_topics
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Trivia
  class Topic < ApplicationRecord

    has_paper_trail

    enum status: %i[draft published locked closed]
    scope :published, -> { where(status: [:published, :locked, :closed]) }

    rails_admin do

    end
  end
end
