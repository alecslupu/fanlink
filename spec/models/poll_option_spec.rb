# frozen_string_literal: true

# == Schema Information
#
# Table name: poll_options
#
#  id                        :bigint           not null, primary key
#  poll_id                   :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  untranslated_description  :jsonb            not null
#  person_poll_options_count :integer
#


require 'rails_helper'

RSpec.describe PollOption, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  # TODO: auto-generated
  describe '#voted?' do
    it 'works' do
      poll_option = PollOption.new
      person = double('person')
      result = poll_option.voted?(person)
      expect(result).not_to be_nil
    end
  end

  # TODO: auto-generated
  describe '#voters' do
    it 'works' do
      poll_option = PollOption.new
      result = poll_option.voters
      expect(result).not_to be_nil
    end
  end

  # TODO: auto-generated
  describe '#votes' do
    it 'works' do
      poll_option = PollOption.new
      result = poll_option.votes
      expect(result).not_to be_nil
    end
  end

  # TODO: auto-generated
  describe '#description_cannot_be_empty' do
    it 'works' do
      poll_option = PollOption.new
      result = poll_option.description_cannot_be_empty
      expect(result).not_to be_nil
    end
  end
end
