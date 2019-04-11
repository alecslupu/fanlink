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
#  photo_file_size    :string
#  photo_content_type :string
#  photo_updated_at   :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  delivered          :boolean          default(FALSE)
#  prize_type         :integer          default("digital")
#

class Trivia::Prize < ApplicationRecord
  belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id

  has_attached_file :photo

  enum status: %i[draft published locked closed]
  enum prize_type: %i[digital physical]

  scope :published, -> { where(status: [:published, :locked]) }
end
