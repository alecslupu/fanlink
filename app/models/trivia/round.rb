# == Schema Information
#
# Table name: trivia_rounds
#
#  id               :bigint(8)        not null, primary key
#  question_count   :integer
#  trivia_game_id   :bigint(8)
#  leaderboard_size :integer          default(100)
#  status           :integer          default("draft"), not null
#  complexity       :integer          default(1)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  start_date       :integer
#  end_date         :integer
#

module Trivia
  class Round < ApplicationRecord
    has_paper_trail
    belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id, counter_cache: :round_count

    has_many :questions, -> { order("question_order") }, class_name: "Trivia::Question", foreign_key: :trivia_round_id, dependent: :destroy
    has_many :leaderboards, class_name: "RoundLeaderboard", foreign_key: :trivia_round_id, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

    enum status: %i[draft published locked running closed]

    scope :visible, -> { where(status: [:published, :locked, :running, :closed]) }

    def compute_gameplay_parameters
      date_to_set = self.start_date
      self.questions.each_with_index do |question, index|
        question.start_date = date_to_set
        question.set_order(1 + index)
        question.compute_gameplay_parameters
        date_to_set = question.end_date_with_cooldown
      end
      self.end_date = self.questions.reload.last.end_date
      self.save
    end

    def end_date_with_cooldown
      self.end_date
    end

    # administrate fallback
    def game_id
      trivia_game_id
    end

    rails_admin do
      parent "Trivia::Game"
      edit do
        fields :status, :complexity
        field :start_date, :unix_timestamp

        field :questions do
          def render
            bindings[:view].render partial: 'rails_admin/main/form_nested_many_orderable', locals: {
              field: self, form: bindings[:form], field_order: :question_order_field
            }
          end
        end
      end
      nested do
        exclude_fields :game
        field :questions do
          visible { bindings[:object].persisted? }

          def render
            bindings[:view].render partial: 'rails_admin/main/form_nested_many_orderable', locals: {
              field: self, form: bindings[:form], field_order: :question_order_field
            }
          end
        end
      end
    end
  end
end
