# == Schema Information
#
# Table name: notifications
#
#  id                     :bigint(8)        not null, primary key
#  body                   :text             not null
#  person_id              :integer          foreign key
#

class Notification < ApplicationRecord
  include Notification::RealTime

  belongs_to :person
  validates :body, presence: true
end
