module Referral
  class ReferredPerson < ApplicationRecord
    belongs_to :inviter, class_name: "Person", foreign_key: :inviter_id, primary_key: :id
    belongs_to :invited, class_name: "Person", foreign_key: :invited_id, primary_key: :id

    scope :with_transactions, -> {
      select('"referral_referred_people".*, COUNT(referral_referred_people.id)').
      joins(invited: :certificates).
      where(certificates: { is_free: false }).
      group(Arel.sql("referral_referred_people.id, person_certificates.person_id"))
    }
  end
end
