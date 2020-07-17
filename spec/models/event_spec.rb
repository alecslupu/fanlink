# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  product_id       :integer          not null
#  name             :text             not null
#  description      :text
#  starts_at        :datetime         not null
#  ends_at          :datetime
#  ticket_url       :text
#  place_identifier :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted          :boolean          default(FALSE), not null
#  latitude         :decimal(10, 6)
#  longitude        :decimal(10, 6)
#


RSpec.describe Event, type: :model do
  context 'Valid' do
    it { expect(build(:event)).to be_valid }
  end

  describe '#ends_at' do
    it 'should not have an ends_at that is before the starts_at' do
      event = build(:event)
      event.ends_at = event.starts_at - 1.day
      expect(event).not_to be_valid
      expect(event.errors[:ends_at]).not_to be_empty
    end
  end

  describe '#name' do
    it 'should not allow an event without a name' do
      event = build(:event, name: nil)
      expect(event).not_to be_valid
      expect(event.errors[:name]).not_to be_blank
    end
    it 'should not allow an event with a blank name' do
      event = build(:event, name: '')
      expect(event).not_to be_valid
      expect(event.errors[:name]).not_to be_blank
    end
  end

  describe '#place_identifier' do
    it 'should normalize blank to nil' do
      event = build(:event, place_identifier: '')
      expect(event.place_identifier).to be_nil
    end
  end

  describe '#starts_at' do
    it 'should not allow an event without a start time' do
      event = build(:event, starts_at: nil)
      expect(event).not_to be_valid
      expect(event.errors[:starts_at]).not_to be_blank
    end
  end

  # TODO: auto-generated
  describe '#place_info' do
    pending
  end
end
