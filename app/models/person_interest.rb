# frozen_string_literal: true

# == Schema Information
#
# Table name: person_interests
#
#  id          :bigint           not null, primary key
#  person_id   :integer          not null
#  interest_id :integer          not null
#

class PersonInterest < ApplicationRecord
  belongs_to :interest
  belongs_to :person, touch: true
  validates_uniqueness_of :interest_id, scope: :person_id

  # def self.match(interests, uid)
  #   #Person.includes(:person_interests)
  #   Person.select("people.id, people.updated_at, array_agg(DISTINCT person_interests.interest_id) as matched_ids")
  #     .joins(:person_interests)
  #     .where("person_interests.interest_id in (?)", interests)
  #     .where("person_interests.person_id != (?)", uid)
  #     .group("people.id")
  #     .order("count(person_interests.*) DESC")
  # end
end
