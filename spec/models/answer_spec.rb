require 'rails_helper'

RSpec.describe Answer, type: :model do

  context "Validation" do

  end

  context "Associations" do
    it { should belong_to(:product) }
    it { should belong_to(:quiz_page) }
  end

  context "Methods" do

  end

  context "Valid factory" do
    it { expect(create(:answer)).to be_valid }
  end
end
