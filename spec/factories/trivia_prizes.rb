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
#  is_delivered       :boolean          default(FALSE)
#  prize_type         :integer          default("digital")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :trivia_prize, class: "Trivia::Prize" do
    game { create(:trivia_game) }
    status { 1 }
    description { "MyText" }
    position { 1 }
  end
end
