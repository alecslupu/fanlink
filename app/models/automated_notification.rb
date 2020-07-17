# frozen_string_literal: true

# == Schema Information
#
# Table name: automated_notifications
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  body         :text             not null
#  person_id    :bigint           not null
#  criteria     :integer          not null
#  enabled      :boolean          default(FALSE), not null
#  product_id   :integer          not null
#  last_sent_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ttl_hours    :integer          default(672), not null
#

class AutomatedNotification < ApplicationRecord
  belongs_to :person, touch: true
  belongs_to :product

  acts_as_tenant(:product)

  has_paper_trail

  enum criteria: {
    inactive_48h: 0,
    inactive_7days: 1,
    inactive_30days: 2
  }

  validates :body, presence: true
  validates :title, presence: true
  validates :criteria, presence: true
  validates :product_id, presence: true
  validates :person_id, presence: true
  validates :ttl_hours, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 672 }
  validate :validate_enabled_criterion

  before_validation :set_person_id

  private

  def set_person_id
    if Person.current_user.product_id == ActsAsTenant.current_tenant.id
      self.person_id = Person.current_user.id
    else
      self.person_id = ActsAsTenant.current_tenant.people.where(product_account: true).first.id
    end
  end

  def validate_enabled_criterion
    if enabled && AutomatedNotification.where(criteria: criteria, enabled: true).exists?
      errors.add(:base, 'There is already an enabled automated notification with the selected criteria. There can be only one enabled notification per criterion.')
    end
  end
end
