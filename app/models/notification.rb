# == Schema Information
#
# Table name: notifications
#
#  id                     :bigint(8)        not null, primary key
#  body                   :text             not null
#  person_id              :integer          foreign key
#  product_id             :integer          not null
#

class Notification < ApplicationRecord
  include Notification::RealTime

  acts_as_tenant(:product)

  belongs_to :person
  validates :body, presence: true
end
