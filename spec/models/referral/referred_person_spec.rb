# frozen_string_literal: true

# == Schema Information
#
# Table name: referral_referred_people
#
#  id         :bigint           not null, primary key
#  inviter_id :bigint
#  invited_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require 'rails_helper'

RSpec.describe Referral::ReferredPerson, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
