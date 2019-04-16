require "rails_helper"

RSpec.describe Certificate, type: :model do

  context "Valid factory" do
    it { expect(create(:certificate)).to be_valid }
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
