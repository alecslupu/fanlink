# -*- encoding: utf-8 -*-

require "spec_helper"

describe Trivia::GameGenerator do
  describe "#generate" do
    it "creates a draft game" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        generator = Trivia::GameGenerator.new
        create_list(:trivia_multiple_choice_available_question, 100)
        expect { generator.generate }.to change {  Trivia::Game.count  }.by(1)
        expect { generator.generate }.to change { Trivia::Round.count }.by(5)
        expect { generator.generate }.to change { Trivia::Question.count }.by(50)
      end
    end
  end
end
