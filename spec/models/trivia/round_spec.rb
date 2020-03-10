require "rails_helper"

RSpec.describe Trivia::Round, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_round)).to be_valid }
  end

  context "status" do
    subject { Trivia::Round.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context "State Machine" do
    subject { Trivia::Round.new(start_date: (Time.zone.now + 1.day).to_i) }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:running).on_event(:running) }
    it { expect(subject).to transition_from(:running).to(:closed).on_event(:closed) }
  end

  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should belong_to(:game)
        should have_many(:questions)
        should have_many(:leaderboards)
      end
    end
  end

  describe ".game_id" do
    it "matches the trivia game id" do
      round = create :started_trivia_round
      expect(round.game_id).to eq(round.trivia_game_id)
    end
  end

  context "complete round" do
    it "" do
      round = create :started_trivia_round

      expect(round.questions.size).to eq(10)
    end
  end

  context "past round" do
    it "has a full leaderboard" do
      round = create :past_trivia_round, with_leaderboard: true
      expect(round.leaderboards.size).to eq(round.leaderboard_size)
    end
  end

  context "scheduled round" do
    describe ".compute_gameplay_parameters" do
      it "has the method" do
        expect(Trivia::Round.new.respond_to?(:compute_gameplay_parameters)).to eq(true)
      end
      it "sets the start_date of a question" do
        time = DateTime.now
        round = create(:future_trivia_round, start_date: time)
        round.compute_gameplay_parameters
        question = round.reload.questions.first
        expect(question.start_date).to be_within(1.seconds).of round.start_date
        expect(question.question_order).to eq(1)
      end

      it "sets the second question at the right interval" do
        time = DateTime.now
        round = create(:future_trivia_round, start_date: time)
        round.compute_gameplay_parameters
        question = round.reload.questions.first(2).last
        expect(question.start_date).to be_within(1.seconds).of round.start_date + 6.seconds
        expect(question.question_order).to eq(2)
      end

      it "sets any question at the right interval" do
        time = DateTime.now
        round = create(:future_trivia_round, start_date: time)
        round.compute_gameplay_parameters

        value = (3..10).to_a.sample

        question = round.reload.questions.first(value).last

        # 7 = time_limit + cooldown
        result = round.start_date + (7 * (value - 1)).seconds

        expect(question.start_date - result).to eq(0)
        expect(question.question_order).to eq(value)
      end
      it "sets the end date correctly on round" do
        time = DateTime.now + 1.day
        round = create(:future_trivia_round, start_date: time)
        round.compute_gameplay_parameters

        question = round.reload.questions.last
        expect(round.end_date).to be_within(1.seconds).of question.end_date
      end
    end
    describe ".end_date_with_cooldown" do
      it "has the method" do
        expect(Trivia::Round.new.respond_to?(:end_date_with_cooldown)).to eq(true)
      end
      it "sets the end date" do
        time = DateTime.now.to_i
        round = create(:future_trivia_round, start_date: time)
        round.compute_gameplay_parameters
        # 46 = 10*1 seconds duration + 10*6 timeouts
        result = time + 64.seconds
        expect(round.end_date_with_cooldown - result).to eq(0)
      end
    end
  end

  context "validations" do
    describe "#start_date" do
      before(:each) do
        game = create(:trivia_game)
        product = create(:product)
        @round = Trivia::Round.new(
          start_date: nil,
          status: :draft,
          trivia_game_id: game.id,
          product_id: product.id
        )
      end
      it "does not save the round when status is locked" do
        @round.status = "locked"
        expect{ @round.save }.not_to change{ Trivia::Round.count }
      end

      it "does not save the round when status is published" do
        @round.status = "published"
        expect{ @round.save }.not_to change{ Trivia::Round.count }
        # expect{ @round.save }.not_to change{ Trivia::Round.count }
      end

      it "does not save the round when status is running" do
        @round.status = "running"
        expect{ @round.save }.not_to change{ Trivia::Round.count }
      end

      it "saves the round when status is draft" do
        expect{ @round.save }.to change{ Trivia::Round.count }.by(1)
      end
    end

    describe "#start_date smaller than current date" do
      before(:each) do
        @round = create(:past_trivia_round, status: :draft, start_date: (DateTime.current - 1.day).to_i)
        @round.publish!
      end

      it "does not update status" do
        expect(@round.status).to eq("draft")
      end

      it "throws an error with a message" do
        expect(@round.errors.messages[:start_date]).to include("must be higher than current date")
      end
    end

    describe "#avalaible_questions_status_check" do
      describe "having unpublished active question when publishing the round" do
        before(:each) do
          @round = create(:past_trivia_round, status: :draft, start_date: (DateTime.current + 1.day).to_i)
          question = create(:trivia_single_choice_question)
          question.available_question.update(status: :draft)
          @round.questions << question
          @round.publish!
        end

        it "does not update status" do
          expect(@round.status).to eq("draft")
        end

        it "throws an error with a message" do
          expect(@round.errors.messages[:base]).to include("All available questions used must have 'published' status before publishing")
        end
      end
    end
  end
end
