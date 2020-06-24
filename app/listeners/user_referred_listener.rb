# frozen_string_literal: true

class UserReferredListener
  def self.person_created(person_id, params)
    return unless params && params[:referrer].present?

    person = Person.find(person_id)
    code = Referral::UserCode.where(unique_code: params[:referrer].try(:downcase)).first!

    Referral::ReferredPerson.create!(invited_id: person.id, inviter_id: code.person_id)

    true
  rescue ActiveRecord::RecordNotFound
    false
  end
end
