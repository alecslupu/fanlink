# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id                     :bigint(8)        not null, primary key
#  product_id             :integer          not null
#  name_text_old          :text
#  created_by_id          :integer
#  status                 :integer          default("inactive"), not null
#  public                 :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  picture_file_name      :string
#  picture_content_type   :string
#  picture_file_size      :integer
#  picture_updated_at     :datetime
#  name                   :jsonb            not null
#  description            :jsonb            not null
#  order                  :integer          default(0), not null
#  last_message_timestamp :bigint(8)        default(0)
#

FactoryBot.define do
  factory :room do
    product { current_product }
    sequence(:name) { |n| "Room #{n}" }
    created_by_id { create(:person).id }

    factory :private_active_room do
      sequence(:public) { false }

      status { :active }
    end

    factory :public_active_room do
      sequence(:public) { true }

      status { :active }
    end
  end
end
