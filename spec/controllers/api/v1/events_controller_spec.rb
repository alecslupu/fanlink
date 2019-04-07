require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do

  describe "#index" do
    it "should get all the events"
    it "should get events specifying one start time"
    it "should get events specifying a start time range"
    it "should not get the events if not logged in"
  end

  describe "#show" do
    it "should get a single event"
    it "should not get the event if not logged in"
    it "should not get event if from a different product"
  end
end
