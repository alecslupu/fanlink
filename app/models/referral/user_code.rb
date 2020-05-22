# frozen_string_literal: true
module Referral
  class UserCode < ApplicationRecord
    has_paper_trail ignore: [:created_at, :updated_at]

    belongs_to :person

    before_create do |subscriber|
      subscriber.unique_code = generate_unique_key(:unique_code)
    end

    private

    def generate_unique_key(field_name)
      loop do
        # They want 7 chars
        key = SecureRandom.uuid.split("-").first.chop!
        break key unless Referral::UserCode.exists?("#{field_name}": key)
      end
    end
  end
end
