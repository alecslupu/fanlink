# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagePage, type: :model do
  context 'Valid' do
    it { expect(build(:image_page)).to be_valid }
  end

  pending "add some examples to (or delete) #{__FILE__}"

  # TODO: auto-generated
  describe '#product' do
    pending
  end
end
