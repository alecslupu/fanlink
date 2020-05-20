# frozen_string_literal: true
# == Schema Information
#
# Table name: relationships
#
#  id              :bigint(8)        not null, primary key
#  requested_by_id :integer          not null
#  requested_to_id :integer          not null
#  status          :integer          default("requested"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Relationship < ApplicationRecord
  # include Relationship::RealTime
  enum status: %i[ requested friended ]

  #  Relationship::RealTime

  def friend_request_accepted_push
    FriendRequestAcceptedPushJob.perform_later(self.id)
  end

  def friend_request_received_push
    FriendRequestReceivedPushJob.perform_later(self.id)
  end
  # eof Relationship::RealTime

  has_paper_trail

  belongs_to :requested_by, class_name: "Person", touch: true
  belongs_to :requested_to, class_name: "Person", touch: true

  validate :check_outstanding
  validate :check_non_self
  validate :valid_status_transition
  validate :people_from_same_product

  scope :pending_to_person, -> (person) { where(status: :requested).where(requested_to: person) }
  scope :for_people, -> (source_person, target_person) { where(requested_to: [source_person, target_person]).where(requested_by: [source_person, target_person]) }
  scope :for_person, -> (person) { where(requested_to: person).or(where(requested_by: person)) }
  scope :for_product, -> (product) { joins("JOIN people ON people.id = relationships.requested_by_id").where("people.product_id = ?", product.id) }


  def person_involved?(person)
    requested_to == person || requested_by == person
  end

private

  def check_non_self
    if requested_by_id == requested_to_id
      errors.add(:base, :self_friended, message: _("You cannot have a relationship with yourself."))
    end
  end

  def check_outstanding
    if requested? && Relationship.where.not(id: id).for_people(requested_by, requested_to).exists?
      errors.add(:base, :existing_friendship, message: _("You already have an existing friendship or friend request to or from that person."))
    end
  end

  def valid_status_transition
    if status_changed?
      if status_was.to_sym == :friended && self.requested?
        errors.add(:status, :valid_status_transition, message: _("You cannot change from friended to requested."))
      end
    end
  end

  def people_from_same_product
    errors.add(
      :base,
      :different_product,
      message: _("You cannot friend a person from a different product")
    ) if requested_to&.product_id != requested_by&.product_id
  end
end
