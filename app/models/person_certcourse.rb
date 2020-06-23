# frozen_string_literal: true

# == Schema Information
#
# Table name: person_certcourses
#
#  id                     :bigint(8)        not null, primary key
#  person_id              :integer          not null
#  certcourse_id          :integer          not null
#  last_completed_page_id :integer
#  is_completed           :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class PersonCertcourse < ApplicationRecord
  has_paper_trail

  belongs_to :person
  belongs_to :certcourse
  validates_uniqueness_of :certcourse_id, scope: :person_id

  scope :for_person, -> (person) { where(person_id: person.id) }
  scope :for_product, -> (product) { joins(:person).where(people: { product_id: product.id }) }

end
