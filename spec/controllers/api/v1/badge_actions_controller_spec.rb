require 'rails_helper'

RSpec.describe Api::V1::BadgeActionsController, type: :controller do
  describe "#create" do
    it "should create a new action and return partially earned badge with highest percent earned"
    it "should not include badge before issued_from time as partially earned badge with highest percent earned"
    it "should create a new action and return single earned badge"
    it "should create a new action and return multiple earned badges"
    it "should create a new action and return nil if everything already earned"
    it "should not create an action if not enough time has passed since last one of this type"
    it "should create an action if enough time has passed since last one of this type"
    it "should not create an action with dup person, action and identifier"
    it "should not create action if missing badge action"
    it "should not create action if missing action type"
  end
end
