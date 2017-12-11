RSpec.describe Person, type: :model do
  describe "email" do
    it "should not let you create a person with a blank email" do
      person = build(:person, email: "")
      expect(person).not_to be_valid
      expect(person.errors[:email]).not_to be_blank
    end
  end

  describe "name" do
    it "should not let you create a person without a name" do
      person = build(:person, name: "")
      expect(person).not_to be_valid
      expect(person.errors[:name]).not_to be_blank
    end
  end


end
