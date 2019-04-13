require "rails_helper"

RSpec.describe CertcoursePage, type: :model do

  context "Valid factory" do
    it { expect(create(:certcourse_page)).to be_valid }
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
