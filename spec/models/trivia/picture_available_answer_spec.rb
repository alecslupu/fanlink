# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_picture_available_answers
#
#  id                   :bigint           not null, primary key
#  question_id          :bigint
#  is_correct           :boolean          default(FALSE), not null
#  status               :integer          default("draft"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  product_id           :integer          not null
#


require 'rails_helper'

RSpec.describe Trivia::PictureAvailableAnswer, type: :model do
  context 'status' do
    subject { Trivia::PictureAvailableAnswer.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context 'State Machine' do
    subject { Trivia::PictureAvailableAnswer.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:closed) }
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
