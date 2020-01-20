class UserReferredListener
  def self.person_created(person_id, params)
    return unless params && params[:referer].present?
    person = Person.find(person_id)
    code = Referral::UserCode.where(unique_code: params[:referer]).first!

    Referral::ReferredPerson.create!(invited_id: person_id, inviter_id: code.person_id)
    true
  rescue ActiveRecord::RecordNotFound
    false
  end
end
