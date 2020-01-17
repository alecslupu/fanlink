module Referal
  class UserCode < ApplicationRecord
    belongs_to :person

    before_create do |subscriber|
      subscriber.unique_code = generate_unique_key(:unique_code)
    end

    private

    def generate_unique_key(field_name)
      loop do
        key = SecureRandom.uuid.split("-").first
        break key unless Referal::UserCode.exists?("#{field_name}": key)
      end
    end
  end
end
