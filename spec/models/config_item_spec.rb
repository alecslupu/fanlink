require 'rails_helper'

RSpec.describe ConfigItem, type: :model do
  context "Validation" do
    describe "should create a valid course" do
      it { expect(build(:config_item)).to be_valid }
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
