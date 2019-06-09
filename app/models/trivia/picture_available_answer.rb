# == Schema Information
#
# Table name: trivia_picture_available_answers
#
#  id                   :bigint(8)        not null, primary key
#  question_id          :bigint(8)
#  is_correct           :boolean          default(FALSE), not null
#  status               :integer          default("draft"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#
module Trivia
  class PictureAvailableAnswer < ApplicationRecord
    include AttachmentSupport

    has_paper_trail
    belongs_to :question, class_name: "Trivia::PictureAvailableQuestion", foreign_key: :question_id, optional: true
    enum status: %i[draft published locked closed]

    has_image_called :picture

    rails_admin do
      parent "Trivia::Game"

      # edit do
      #   fields :title, :time_limit, :status, :question_order, :cooldown_period
      #   #  trivia_round_id :bigint(8)
      #   #  type            :string
      #   #  start_date      :integer
      #   #  end_date        :integer
      #
      #   field :available_answers
      # end
      nested do
        exclude_fields :question
      end
    end

    def product
      Product.where(internal_name: 'caned').first
    end
  end
end
