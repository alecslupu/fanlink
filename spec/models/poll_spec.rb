require "rails_helper"

RSpec.describe Poll, type: :model do
  # # TODO: auto-generated
  # describe "#closed?" do
  #   pending
  # end

  # # TODO: auto-generated
  # describe "#start_date_cannot_be_in_the_past" do
  #   pending
  # end

  # # TODO: auto-generated
  # describe "#description_cannot_be_empty" do
  #   pending
  # end

  # # TODO: auto-generated
  # describe "#was_voted" do
  #   pending
  # end

  context "Valid factory" do
    it { expect(create(:poll)).to be_valid }
  end

  context "Validations" do
    subject { Poll.new(start_date: DateTime.now + 1.day, end_date: DateTime.now + 2.day) }

    describe "uniqueness of poll_type and poll_type_id" do
      it "returns an error when poll_type and poll_type_id pair is not unique" do
        poll = create(:poll)
        subject.poll_type = poll.poll_type
        subject.poll_type_id = poll.poll_type_id
        subject.valid?
        expect(subject.errors[:poll_type_id].first).to include("has already been used on that Post")
      end
    end

    describe "#description_cannot_be_empty" do
      it "returns an error when description is empty" do
        subject.description = ""
        subject.valid?
        expect(subject.errors[:description_error].first).to include("description can't be empty")
      end
    end
  end


  # pending "add some examples to (or delete) #{__FILE__}"
end
