# frozen_string_literal: true

# == Schema Information
#
# Table name: portal_accesses
#
#  id                     :bigint           not null, primary key
#  person_id              :integer          not null
#  post                   :integer          default(0), not null
#  chat                   :integer          default(0), not null
#  event                  :integer          default(0), not null
#  merchandise            :integer          default(0), not null
#  user                   :integer          default(0), not null
#  badge                  :integer          default(0), not null
#  reward                 :integer          default(0), not null
#  quest                  :integer          default(0), not null
#  beacon                 :integer          default(0), not null
#  reporting              :integer          default(0), not null
#  interest               :integer          default(0), not null
#  courseware             :integer          default(0), not null
#  trivia                 :integer          default(0), not null
#  admin                  :integer
#  root                   :integer          default(0)
#  portal_notification    :integer          default(0), not null
#  automated_notification :integer          default(0), not null
#  marketing_notification :integer          default(0), not null
#


RSpec.describe PortalAccess, type: :model do
  context 'Validation' do
    describe 'should create a valid portal access' do
      it do
        expect(build(:portal_access)).to be_valid
      end
    end
  end

  # TODO: auto-generated
  describe '#summarize' do
    it 'works' do
      portal_access = PortalAccess.new
      result = portal_access.summarize
      expect(result).not_to be_nil
    end
  end
end
