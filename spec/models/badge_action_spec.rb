require 'rails_helper'

RSpec.describe BadgeAction, type: :model do

  describe "product sanity" do
    it "should not create a badge action from the wrong product" do
      prod1 = create(:product)
      prod2 = create(:product)
      person1 = create(:person, product: prod1)
      at2 = create(:action_type, product: prod2)
      act = BadgeAction.new(person: person1, action_type: at2)
      expect(act).not_to be_valid
    end
  end

end
