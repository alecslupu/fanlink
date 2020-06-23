# frozen_string_literal: true

module Trivia
  class AnswerPolicy < TriviaModulePolicy

    def create?
      false
    end

    def new?
      create?
    end

    def update?
      false
    end

    def edit?
      update?
    end

    def destroy?
      false
    end
  end
end
