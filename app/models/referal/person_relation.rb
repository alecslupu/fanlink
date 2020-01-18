module Referal
  module PersonRelation
    extend ActiveSupport::Concern
    included do
      has_one :referal_code, class_name: "Referal::UserCode"

      has_many :referals, class_name: "Referal::ReferedPerson", inverse_of: :inviter, foreign_key: :inviter_id
      has_many :refered_people, through: :referals, source: :invited
      has_one :refered, class_name: "Referal::ReferedPerson", inverse_of: :invited, foreign_key: :invited_id
      has_one :refered_by, through: :refered, source: :inviter

      def find_or_create_referal_code
        referal_code || create_referal_code!
      end
    end
  end
end
