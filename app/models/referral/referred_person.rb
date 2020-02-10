module Referral
  class ReferredPerson < ApplicationRecord
    belongs_to :inviter, class_name: "Person", foreign_key: :inviter_id, primary_key: :id
    belongs_to :invited, class_name: "Person", foreign_key: :invited_id, primary_key: :id
  end
end
