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

  def self.match(interests)
    p interests.inspect
    #Person.includes(:person_interests)
    Person.select("people.id, people.updated_at, array_agg(DISTINCT person_interests.interest_id) as matched_ids")
      .joins(:person_interests)
      .where("person_interests.interest_id in (?)", interests)
      .group("people.id")
      .order("count(person_interests.*) DESC")
      .limit(15)
  end
end
