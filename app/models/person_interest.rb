# == Schema Information
#
# Table name: person_interests
#
#  id          :bigint(8)        not null, primary key
#  person_id   :integer          not null
#  interest_id :integer          not null
#

class PersonInterest < ApplicationRecord
  belongs_to :interest
  belongs_to :person, touch: true
  validates_uniqueness_of :interest_id, scope: :person_id
end
