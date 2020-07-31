# frozen_string_literal: true

# == Schema Information
#
# Table name: referral_user_codes
#
#  id          :bigint           not null, primary key
#  person_id   :bigint
#  unique_code :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Referral
  class UserCode < ApplicationRecord
    belongs_to :person

    before_create do |subscriber|
      subscriber.unique_code = generate_unique_key(:unique_code)
    end

    private

    def generate_unique_key(field_name)
      loop do
        # They want 7 chars
        key = SecureRandom.uuid.split('-').first.chop!
        break key unless Referral::UserCode.exists?("#{field_name}": key)
      end
    end
  end
end
