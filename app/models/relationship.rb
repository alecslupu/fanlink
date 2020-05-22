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

  has_paper_trail ignore: [:created_at, :updated_at]


  belongs_to :requested_by, class_name: "Person", touch: true
  belongs_to :requested_to, class_name: "Person", touch: true

  validate :check_outstanding
  validate :check_non_self
  validate :valid_status_transition

  scope :pending_to_person, -> (person) { where(status: :requested).where(requested_to: person) }
  scope :for_people, -> (source_person, target_person) { where(requested_to: [source_person, target_person]).where(requested_by: [source_person, target_person]) }
  scope :for_person, -> (person) { where(requested_to: person).or(where(requested_by: person)) }

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
end
