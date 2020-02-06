module Referral
  module PersonRelation
    extend ActiveSupport::Concern
    included do
      has_one :referral_code, class_name: "Referral::UserCode"

      has_many :referrals, class_name: "Referral::ReferredPerson", inverse_of: :inviter, foreign_key: :inviter_id
      has_many :referred_people, through: :referrals, source: :invited
      has_one :referred, class_name: "Referral::ReferredPerson", inverse_of: :invited, foreign_key: :invited_id
      has_one :referred_by, through: :referred, source: :inviter

      def find_or_create_referral_code
        referral_code || create_referral_code!
      end
    end
  end
end
