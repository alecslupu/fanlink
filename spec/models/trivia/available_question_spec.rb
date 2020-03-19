require "rails_helper"


RSpec.describe Trivia::AvailableQuestion, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_multiple_choice_available_question)).to be_valid }
    it { expect(build(:trivia_single_choice_available_question)).to be_valid }
    it { expect(build(:trivia_picture_available_question)).to be_valid }
    it { expect(build(:trivia_boolean_choice_available_question)).to be_valid }
    it { expect(build(:trivia_hangman_available_question)).to be_valid }

  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#belongs_to" do
        should belong_to(:topic)
      end
      it "#has_many" do
        should have_many(:available_answers)
        should have_many(:active_questions)
      end
    end
  end

  context "status" do
    subject { Trivia::AvailableQuestion.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context "State Machine" do
    subject { Trivia::AvailableQuestion.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:closed) }
  end

  context "Validations" do
    describe "#avalaible_answers_status_check" do
      describe "publishing a question before publishing available questions" do
        before(:each) do
          available_answer = create(:trivia_available_answer, status: :draft)
          @available_question = create(:trivia_single_choice_available_question, status: :draft)
          @available_question.available_answers << available_answer
          @available_question.publish!
        end
        it "does not update status" do
          expect(@available_question.status).to eq("draft")
        end

        it "throws an error with a message" do
          expect(@available_question.errors.messages[:available_answers]).to include("used in the questions must have 'published' status before publishing")
        end
      end
    end

    describe "hangman_answer" do
      describe "adding more than one answer on fill in the blanks questions" do
        before(:each) do
          @available_question = build(:trivia_hangman_available_question)
          @available_question.available_answers << create(:wrong_trivia_available_answer)
        end

        it "does not save the question" do
          expect { @available_question.save }.not_to change{ Trivia::HangmanAvailableQuestion.count }
        end

        it "throws an error with a message" do
          @available_question.save
          expect(@available_question.errors.messages[:avalaible_answers]).to include("count must be equal to one for fill in the blank questions and that answer must be correct.")
        end
      end

      describe "adding an incorrect answer on fill in the blanks questions" do
        before(:each) do
          @available_question = build(:trivia_hangman_available_question)
          @available_question.available_answers.first.update(is_correct: false)
        end
        it "does not save the question" do
          expect { @available_question.save }.not_to change{ Trivia::HangmanAvailableQuestion.count }
        end

        it "throws an error with a message" do
          @available_question.save
          expect(@available_question.errors.messages[:avalaible_answers]).to include("count must be equal to one for fill in the blank questions and that answer must be correct.")
        end
      end
    end

    describe "#title" do
      before(:each) do
        @available_question = build(:trivia_available_question, title: nil)
      end

      it "does not save the record" do
        expect { @available_question.save }.not_to change{ Trivia::AvailableQuestion.count }
      end

      it "throws an error with a message" do
        @available_question.save
        expect(@available_question.errors.messages[:title]).to include("can't be blank")
      end
    end
  end

  context "hooks" do
    describe "#update_questions_type" do
      describe "after updating an available question's type" do
        before(:each) do
          question = create(:trivia_single_choice_question)
          @available_question = question.available_question
          # must assign a correct answer to passthe valdiations
          @available_question.available_answers << create(:correct_trivia_available_answer)
          @available_question.update(type: "Trivia::MultipleChoiceAvailableQuestion")
          # you can't use record.reload because it searches based on the old record's type
          @updated_question = Trivia::Question.find(question.id)
        end

        it "updates all the types for the questions that it is assigned to" do
          expect(@updated_question.type).to eq("Trivia::MultipleChoiceQuestion")
        end
      end
    end
  end
end
