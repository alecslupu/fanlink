RSpec.describe Person, type: :model do

  before(:all) do
    @username = "Whére.Ïs.Pañçâkèß.HOUSE"
    @password = "logmein"
    @email = "pancakes@example.com"
    @person = create(:person, email: @email, username: @username, password: @password)
    ActsAsTenant.current_tenant = @person.product
  end

  context "Valid" do
    it "should create a valid person" do
      expect(create(:person)).to be_valid
    end
  end

  context "Validation for normal user" do
    describe "#presence" do
      it do
        should validate_presence_of(:username).with_message(_("Username is required."))
        should validate_presence_of(:password).with_message(_("Password is required."))
      end
    end
    describe "#length" do
      it do
        should validate_length_of(:username).is_at_least(3).is_at_most(26).with_message(_("Username must be between 3 and 26 characters"))
        should validate_length_of(:password).is_at_least(6).with_message(_("Password must be at least 6 characters in length."))
      end
    end

    describe "#uniqueness" do
      it "should allow duplicate emails and usernames for differnt products" do
        product = create(:product)
        product2 = create(:product)
        person1 = build(:person, product: product, username: "Joe2987", email: "Joe2987@example.com")
        person2 = build(:person, product: product2, username: "Joe2987", email: "Joe2987@example.com")

        expect(person1).to be_valid
        expect(person2).to be_valid
      end

      it "should not allow duplicate emails and usernames for same product" do
        product = create(:product)
        person1 = create(:person, product: product, username: "Person1", password: "testpassword", email: "person1@example.com")
        person2 = build(:person, product: product, username: "Person1", password: "testpassword", email: "person1@example.com")

        expect(person1).to be_valid
        expect(person2).not_to be_valid
      end
    end

    describe "#format" do
      subject { FactoryBot.build(:person) }
      it "should not allow emoji's for name on creation" do
        should_not allow_value("Person \uFE0F").for(:name).on(:create).with_message(_("Name may not contain emojis."))
      end
      it "should not allow emoji's for username on creation" do
        should_not allow_value("Person_\uFE0F").for(:username).on(:create).with_message(_("Username may not contain emojis."))
      end
    end
  end

  context "Validation as facebook user" do
    describe "#presence" do
      it "should not validate the email if a facebook id is present" do
        person = create(:person, facebookid: "123013910sdaa", email: nil)
        expect(person).to be_valid
      end

      it "should not validate the password if a facebook id is present" do
        person = create(:person, facebookid: "123013910sdaa", password: nil)
        expect(person).to be_valid
      end
    end

    describe "#length" do
      it "should not validate length of password if a facebook id is present" do
        person = create(:person, facebookid: "asdjaj231klkda", password: nil)
        expect(person).to be_valid
      end
    end
  end

  context "Associations" do
    describe "#has_many" do
      it "should verify associations" do
        should have_many(:message_reports)
        should have_many(:notification_device_ids)
        should have_many(:post_reactions)
        should have_many(:room_memberships)
        should have_many(:posts)
        should have_many(:quest_completions)
        should have_many(:step_completed)
        should have_many(:quest_completed)
        should have_many(:person_rewards)
        should have_many(:person_interests)
        should have_many(:level_progresses)
        should have_many(:reward_progresses)
        should have_many(:messages)
        should have_many(:event_checkins)

        should have_many(:rewards).through(:person_rewards)
        # should have_many(:private_rooms).through(:room_memberships) # Currently fails with nilClass on room_memberships
        should have_many(:interests).through(:person_interests)
      end
    end

    describe "#has_one" do
      it "should verify associations" do
        should have_one(:portal_access)
      end
    end

    describe "#belongs_to" do
      it "should verify associations" do
        should belong_to(:product)
      end
    end
  end

  context "Filters" do
    describe "#username_filter" do
    end
    describe "#email_filter" do
    end
  end

  describe "#block" do
    it "should block a user" do
      to_be_blocked = create(:person)
      @person.block(to_be_blocked)
      expect(@person.blocked?(to_be_blocked)).to be_truthy
    end
    it "should unblock a user" do
      to_be_unblocked = create(:person)
      @person.block(to_be_unblocked)
      expect(@person.blocked?(to_be_unblocked)).to be_truthy
      @person.unblock(to_be_unblocked)
      expect(@person.blocked?(to_be_unblocked)).to be_falsey
    end
  end

  describe "#country" do
    it "should accept a valid country code" do
      person = create(:person, country_code: "US")
      expect(person).to be_valid
      expect(person.country_code).to eq("US")
    end
    it "should not accept an invalid country code" do
      person = build(:person, country_code: "USA")
      expect(person).not_to be_valid
      expect(person.errors[:country_code]).not_to be_empty
    end
    it "should accept an empty string country code" do
      person = build(:person, country_code: "")
      expect(person).to be_valid
      expect(person.country_code).to be_nil
    end
    it "should upcase it" do
      person = create(:person, country_code: "us")
      expect(person.reload.country_code).to eq("US")
    end
  end

  describe "#destroy" do
    it "should not let you destroy a person who has reported a message" do
      person = create(:person)
      create(:message_report, person: person)
      expect(person.destroy).to be_falsey
      expect(person).to exist_in_database
    end
  end

  describe "#do_auto_follows" do
    it "should auto follow the right accounts and only those" do
      ActsAsTenant.with_tenant(create(:product)) do
        create(:person, auto_follow: true, product: create(:product))
      end
      auto1 = create(:person, auto_follow: true)
      auto2 = create(:person, auto_follow: true)
      create(:person, auto_follow: false)
      person = create(:person)
      person.do_auto_follows
      expect(person.following.sort).to eq([auto1, auto2].sort)
    end
  end
  describe "#badge_points" do
    it "should give the total point value of badges earned when no badges earned" do
      person = create(:person)
      expect(person.badge_points).to eq(0)
    end
    it "should give the total point value of badges earned when one badge earned" do
      person = create(:person)
      ba = create(:badge_award, person: person)
      expect(person.badge_points).to eq(ba.badge.point_value)
    end
    it "should give the total point value of badges earned when multiple badges earned" do
      person = create(:person)
      ba1 = create(:badge_award, person: person)
      ba2 = create(:badge_award, person: person)
      expect(person.badge_points).to eq(ba1.badge.point_value + ba2.badge.point_value)
    end
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

  describe "#follow" do
    it "should follow a person" do
      fwer = create(:person)
      fwed = create(:person)
      expect(fwer.following?(fwed)).to be_falsey
      fwer.follow(fwed)
      expect(fwer.following?(fwed)).to be_truthy
    end
  end

  describe "#follow" do
    it "should unfollow a person" do
      fwer = create(:person)
      fwed = create(:person)
      fwer.follow(fwed)
      expect(fwer.following?(fwed)).to be_truthy
      fwer.unfollow(fwed)
      expect(fwer.following?(fwed)).to be_falsey
    end
  end

  describe ".for_username" do
    it "should return a user for a valid username" do
      expect(Person.for_username(@person.username)).to eq(@person)
    end
    it "should return nil for an invalid username" do
      expect(Person.for_username("fafdasfdsfkddddd")).to be_nil
    end
  end

  describe ".friend_request_count" do
    it "should give the number of oustanding friend request to person with none" do
      expect(create(:person).friend_request_count).to eq(0)
    end
    it "should give the number of oustanding friend request to person with one new friend request" do
      create(:relationship, requested_to: @person)
      expect(@person.friend_request_count).to eq(1)
    end
    it "should give the number of oustanding friend request to person with one new friend request and one accepted" do
      create(:relationship, requested_to: @person)
      create(:relationship, requested_to: @person, status: :friended)
      expect(@person.friend_request_count).to eq(1)
    end
  end

  describe "#level_earned" do
    it "should be nil for person with no badges" do
      person = create(:person)
      expect(person.level_earned).to be_nil
    end
    it "should be nil for person with one badge below first level" do
      ActsAsTenant.with_tenant(create(:product)) do
        person = create(:person)
        badge = create(:badge, point_value: 10)
        level_earned = create(:level, points: 20)
        create(:level_progress, person: person, points: { badge_action: 10 }, total: 10)
        person.reload
        expect(person.level_earned_from_progresses(person.level_progresses)).to be_nil
      end
    end
    it "should be right level for person with one badge above only level" do
      ActsAsTenant.with_tenant(create(:product)) do
        person = create(:person)
        badge = create(:badge, point_value: 20)
        level_earned = create(:level, points: 10)
        create(:level_progress, person: person, points: { badge_action: 20 }, total: 20)
        person.reload
        expect(person.level_earned_from_progresses(person.level_progresses)).to eq(level_earned)
      end
    end
    it "should be right level for person with one badge between levels" do
      ActsAsTenant.with_tenant(create(:product)) do
        person = create(:person)
        badge = create(:badge, point_value: 20)
        level1 = create(:level, points: 10)
        level2 = create(:level, points: 21)
        create(:level_progress, person: person, points: { badge_action: 20 }, total: 20)
        person.reload
        expect(person.level_earned_from_progresses(person.level_progresses)).to eq(level1)
      end
    end
  end

  describe "#role" do
    it "should allow super in a product that can have such" do
      prod = create(:product, can_have_supers: true)
      ActsAsTenant.with_tenant(prod) do
        person = create(:person, role: :super_admin)
        expect(person).to be_valid
      end
    end
    it "should not allow super in a product that cannot have such" do
      prod = create(:product)
      ActsAsTenant.with_tenant(prod) do
        person = build(:person, role: :super_admin)
        expect(person).not_to be_valid
        expect(person.errors[:role]).not_to be_empty
      end
    end
  end

  describe ".roles_for_select" do
    it "should return all roles for a product that can have supers" do
      ActsAsTenant.with_tenant(create(:product, can_have_supers: true)) do
        expect(create(:person).roles_for_select).to eq(Person.roles)
      end
    end
    it "should return all roles except suerp for a product that cannot have supers" do
      ActsAsTenant.with_tenant(create(:product, can_have_supers: false)) do
        expect(create(:person).roles_for_select).to eq(Person.roles.except(:super_admin))
      end
    end
  end

  describe "#some_admin?" do
    it "should return false for normal" do
      person = create(:person)
      expect(person.some_admin?).to be_falsey
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
        }.to change { Person.count }.by(1)
        expect(p).to eq(Person.last)
      end
      it "should return nil if api error" do
        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).with("me", fields: [:id, :email, :picture]).and_raise(Koala::Facebook::APIError.new(nil, nil))
        expect(Person.create_from_facebook("12345", "fdafafadadfa")).to be_nil
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
      it "should return nil if given bad token" do
        tok = "1234567"
        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).with("me", fields: [:id]).and_raise(Koala::Facebook::APIError.new(nil, nil))
        expect(Person.for_facebook_auth_token(tok)).to be_nil
      end
    end
  end
end
