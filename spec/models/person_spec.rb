RSpec.describe Person, type: :model do

  before(:all) do
    @username = "Whére.Ïs.Pañçâkèß.HOUSE"
    @password = "logmein"
    @email = "pancakes@example.com"
    @person = create(:person, email: @email, username: @username, password: @password)
    ActsAsTenant.current_tenant = Product.first
  end

  describe "#email" do
    it "should not let you create a person with a blank email" do
      person = build(:person, email: "")
      expect(person).not_to be_valid
      expect(person.errors[:email]).not_to be_blank
    end
    it "should not let you create a person with a nil email if no facebookid" do
      person = build(:person, email: "")
      expect(person).not_to be_valid
      expect(person.errors[:email]).not_to be_blank
    end
    it "should let you create a person with a nil email if facebookid present" do
      person = build(:person, email: nil, facebookid: "12345")
      expect(person).to be_valid
    end
    it "should normalize email" do
      person = create(:person, email: " SOMEcapsinHere@example.com ")
      expect(person.email).to eq("somecapsinhere@example.com")
    end
  end

  describe ".can_login?" do
    it "should return person if correct username supplied" do
      expect(Person.can_login?(@username)).to eq(@person)
    end
    it "should return person if correct email supplied" do
      expect(Person.can_login?(@email)).to eq(@person)
    end
    it "should return nil if username supplied and does not exist" do
      expect(Person.can_login?("nonexistentiamsure")).to be_nil
    end
    it "should return nil if email supplied and does not exist" do
      expect(Person.can_login?("nonexistentiamsure@example.com")).to be_nil
    end
  end

  describe "#username" do
    it "should not let you create a person with a username less than 3 characters" do
      person = build(:person, username: "ab")
      expect(person).not_to be_valid
      expect(person.errors[:username]).not_to be_blank
    end
    it "should not let you create a person with a username more than 26 characters" do
      person = build(:person, username: "abcdefghijklmnopqrstuvwxyza")
      expect(person).not_to be_valid
      expect(person.errors[:username]).not_to be_blank
    end
    it "should not let you create a person without a username" do
      person = build(:person, username: "")
      expect(person).not_to be_valid
      expect(person.errors[:username]).not_to be_blank
    end
    it "should properly mangle the username into a slug" do
      expect(@person.username_canonical).to eq("whereispancakeßhouse")
    end
    it "should ignore accents, case, and punctuation when using for_username" do
      examples = [ "Whére.Ïs.Pañçâkèß.HOUSE", "where.is.pancakeß.house",
                   "whereispancakeßhouse", "where-is_pancakeß.house", "where@is_pancakeß.house" ]
      examples.each do |e|
        expect(Person.named_like(e)).to eq(@person)
      end
    end
  end

  describe "Facebook" do
    describe ".create_from_facebook" do
      it "should create and return a new user from valid FB auth token" do
        username = "somedude#{Time.now.to_i}"
        koala_result = { "id" => Time.now.to_i.to_s, "name" => "John Smith" }
        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
        p = nil
        expect {
          p = Person.create_from_facebook("12345", username)
        }.to change{ Person.count }.by(1)
        expect(p).to eq(Person.last)
      end
    end
    describe ".for_facebook_auth_token" do
      it "should return person with FB id if given proper token" do
        fbid = "123456"
        tok = "1234567"
        person = create(:person, facebookid: fbid)
        koala_result = { "id" => fbid, "name" => "John Smith" }
        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
        expect(Person.for_facebook_auth_token(tok)).to eq(person)
      end
    end
  end
end
