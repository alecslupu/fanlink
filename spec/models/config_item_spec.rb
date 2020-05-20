# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ConfigItem, type: :model do
  context "Validation" do
    describe "should create a valid course" do
      it { expect(build(:string_config_item)).to be_valid }
      it { expect(build(:array_config_item)).to be_valid }
      it { expect(build(:boolean_config_item)).to be_valid }
      it { expect(build(:root_config_item)).to be_valid }
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end

