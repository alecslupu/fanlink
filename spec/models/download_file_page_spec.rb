# frozen_string_literal: true
require "rails_helper"

RSpec.describe DownloadFilePage, type: :model do
  context "Validation" do
    describe "should create a valid course" do
      it { expect(build(:download_file_page)).to be_valid }
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
