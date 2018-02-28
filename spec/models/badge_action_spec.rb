RSpec.describe BadgeAction, type: :model do

  describe "#identifier" do
    it "should not allow duplicate person, action type and non null identifier" do
      person = create(:person)
      ident = "myaction"
      ActsAsTenant.with_tenant(person.product) do
        action_type = create(:action_type)
        ba1 = BadgeAction.create(action_type_id: action_type.id, person_id: person.id, identifier: ident)
        ba2 = BadgeAction.new(action_type_id: action_type.id, person_id: person.id, identifier: ident)
        expect(ba2).not_to be_valid
        expect(ba2.errors[:identifier]).not_to be_empty
      end
    end
    it "should allow duplicate person, action type with null identifier" do
      person = create(:person)
      ident = "myaction2"
      ActsAsTenant.with_tenant(person.product) do
        action_type = create(:action_type)
        ba1 = BadgeAction.create(action_type_id: action_type.id, person_id: person.id, identifier: ident)
        ba2 = BadgeAction.create(action_type_id: action_type.id, person_id: person.id)
        expect(ba2).to be_valid
      end
    end
    it "should allow duplicate action type and identifier with different people" do
      person1 = create(:person)
      ident = "myaction2"
      ActsAsTenant.with_tenant(person1.product) do
        person2 = create(:person)
        action_type = create(:action_type)
        ba1 = BadgeAction.create(action_type_id: action_type.id, person_id: person1.id, identifier: ident)
        ba2 = BadgeAction.create(action_type_id: action_type.id, person_id: person2.id, identifier: ident)
        expect(ba2).to be_valid
      end
    end
    it "should allow duplicate identifier and person with different action type" do
      person = create(:person)
      ident = "myaction2"
      ActsAsTenant.with_tenant(person.product) do
        action_type1 = create(:action_type)
        action_type2 = create(:action_type)
        ba1 = BadgeAction.create(action_type_id: action_type1.id, person_id: person.id, identifier: ident)
        ba2 = BadgeAction.create(action_type_id: action_type2.id, person_id: person.id, identifier: ident)
        expect(ba2).to be_valid
      end
    end
  end
end
