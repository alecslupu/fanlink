# frozen_string_literal: true

# == Schema Information
#
# Table name: portal_accesses
#
#  id                  :bigint(8)        not null, primary key
#  person_id           :integer          not null
#  post                :integer          default(0), not null
#  chat                :integer          default(0), not null
#  event               :integer          default(0), not null
#  merchandise         :integer          default(0), not null
#  user                :integer          default(0), not null
#  badge               :integer          default(0), not null
#  reward              :integer          default(0), not null
#  quest               :integer          default(0), not null
#  beacon              :integer          default(0), not null
#  reporting           :integer          default(0), not null
#  interest            :integer          default(0), not null
#  courseware          :integer          default(0), not null
#  trivia              :integer          default(0), not null
#  admin               :integer
#  root                :integer          default(0)
#  portal_notification :integer          default(0), not null
#

class PortalAccess < ApplicationRecord
  has_paper_trail ignore: [:created_at, :updated_at]

  include PermissionMatrix

  scope :for_product, -> (product) { joins(:person).where(people: { product_id: product.id }) }
  belongs_to :person
end
