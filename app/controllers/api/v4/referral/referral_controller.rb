# frozen_string_literal: true

class Api::V4::Referral::ReferralController < ApiController

  def index
    @people = current_user.referred_people.order(created_at: :desc, id: :desc)
    render :index, handler: :jb
  end

  def purchased
    @people = current_user.
      referred_people.
      select('people.*, count(person_certificates.person_id)').
      joins(:certificates).
      where(certificates: { is_free: false }).
      group(Arel.sql('people.id, person_certificates.person_id')).
      order(created_at: :desc, id: :desc)
    render :index, handler: :jb
  end
end
