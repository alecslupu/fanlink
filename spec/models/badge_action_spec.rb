# frozen_string_literal: true

# == Schema Information
#
# Table name: badge_actions
#
#  id             :bigint           not null, primary key
#  action_type_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  identifier     :text
#


RSpec.describe BadgeAction, type: :model do
  subject {
    create(:badge_action,
           action_type_id: create(:action_type).id,
           person_id: create(:person).id,
           identifier: 'myaction')
  }

  context 'Valid factory' do
    it { expect(build(:badge_action)).to be_valid }
  end
  context 'Associations' do
    describe '#belongs_to' do
      it { should belong_to(:action_type) }
      it { should belong_to(:person).touch(true) }
    end
  end
  context 'Validations' do
    describe 'Uniqueness' do
      it {
        should validate_uniqueness_of(:identifier)
          .scoped_to(%i[person_id action_type_id])
          .allow_nil
          .with_message(_('Sorry, you cannot get credit for that action again.'))
      }
    end
  end
  describe '#identifier' do
    it 'should not allow duplicate person, action type and non null identifier' do
      person = create(:person)
      ident = 'myaction'
      ActsAsTenant.with_tenant(person.product) do
        action_type = create(:action_type)
        ba1 = BadgeAction.create(action_type_id: action_type.id, person_id: person.id, identifier: ident)
        ba2 = BadgeAction.new(action_type_id: action_type.id, person_id: person.id, identifier: ident)
        expect(ba2).not_to be_valid
        expect(ba2.errors[:identifier]).not_to be_empty
      end
    end
    it 'should allow duplicate person, action type with null identifier' do
      person = create(:person)
      ident = 'myaction2'
      ActsAsTenant.with_tenant(person.product) do
        action_type = create(:action_type)
        ba1 = BadgeAction.create(action_type_id: action_type.id, person_id: person.id, identifier: ident)
        ba2 = BadgeAction.create(action_type_id: action_type.id, person_id: person.id)
        expect(ba2).to be_valid
      end
    end
    it 'should allow duplicate action type and identifier with different people' do
      person1 = create(:person)
      ident = 'myaction2'
      ActsAsTenant.with_tenant(person1.product) do
        person2 = create(:person)
        action_type = create(:action_type)
        ba1 = BadgeAction.create(action_type_id: action_type.id, person_id: person1.id, identifier: ident)
        ba2 = BadgeAction.create(action_type_id: action_type.id, person_id: person2.id, identifier: ident)
        expect(ba2).to be_valid
      end
    end
    it 'should allow duplicate identifier and person with different action type' do
      person = create(:person)
      ident = 'myaction2'
      ActsAsTenant.with_tenant(person.product) do
        action_type1 = create(:action_type)
        action_type2 = create(:action_type)
        ba1 = BadgeAction.new(action_type_id: action_type1.id, person_id: person.id, identifier: ident)
        ba2 = BadgeAction.new(action_type_id: action_type2.id, person_id: person.id, identifier: ident)
        expect(ba2).to be_valid
      end
    end
  end
end
