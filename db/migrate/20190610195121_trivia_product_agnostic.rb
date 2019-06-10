class TriviaProductAgnostic < ActiveRecord::Migration[5.1]
  def up

    %w(
      trivia_answers
      trivia_available_answers
      trivia_available_questions
      trivia_questions
      trivia_prizes
      trivia_question_leaderboards
      trivia_rounds
      trivia_round_leaderboards
      trivia_subscribers
      trivia_game_leaderboards
      trivia_topics
      trivia_picture_available_answers
    ).each do |table_name|
      remove_foreign_key table_name, :products
      remove_index table_name, :product_id
      remove_column table_name, :product_id
    end
  end
end
