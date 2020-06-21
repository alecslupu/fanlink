# frozen_string_literal: true

require "rails_helper"

RSpec.describe HackedMetric, type: :model do
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#belong_to" do
        should belong_to(:product)
        should belong_to(:person)
        should belong_to(:action_type)
      end
    end
  end
end
