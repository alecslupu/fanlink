# frozen_string_literal: true

# == Schema Information
#
# Table name: person_interests
#
#  id          :bigint           not null, primary key
#  person_id   :integer          not null
#  interest_id :integer          not null
#


RSpec.describe PersonInterest, type: :model do
  context 'Validation' do
    describe 'should create a valid person interest join' do
      it do
        expect(build(:person_interest)).to be_valid
      end
    end
  end
end
