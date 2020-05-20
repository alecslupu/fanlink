# frozen_string_literal: true
require "rails_helper"

RSpec.describe Certificate, type: :model do
  context "Valid factory" do
    it { expect(build(:certificate)).to be_valid }
  end
  pending "add some examples to (or delete) #{__FILE__}"

  # TODO: auto-generated
  describe "#title" do
    it "works" do
      certificate = build(:certificate)
      expect(certificate.title).to eq(certificate.short_name)
    end
  end
end
