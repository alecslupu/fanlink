# == Schema Information
#
# Table name: trivia_prizes
#
#  id                 :bigint(8)        not null, primary key
#  trivia_game_id     :bigint(8)
#  status             :integer          default("draft"), not null
#  description        :text
#  position           :integer          default(1), not null
#  photo_file_name    :string
#  photo_file_size    :integer
#  photo_content_type :string
#  photo_updated_at   :string
#  is_delivered       :boolean          default(FALSE)
#  prize_type         :integer          default("digital")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#

module Trivia
  class Prize < ApplicationRecord
    include AttachmentSupport
    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }


    has_paper_trail
    belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id

    has_image_called :photo

    enum status: %i[draft published locked closed]
    enum prize_type: %i[digital physical]

    def game_id
      trivia_game_id
    end

    scope :visible, -> { where(status: [:published, :locked]) }

    rails_admin do
      parent "Trivia::Game"

      nested do
        exclude_fields :game
      end
    end
  end
end
