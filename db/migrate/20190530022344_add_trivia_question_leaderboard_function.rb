class AddTriviaQuestionLeaderboardFunction < ActiveRecord::Migration[5.1]
  def up
    begin
      execute %Q(DROP FUNCTION compute_trivia_question_leaderboard(integer))
    rescue ActiveRecord::StatementInvalid => e
    end
    execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_question_leaderboard(question_id integer)
RETURNS void AS $$
  BEGIN
    -- Select the questions in round
    INSERT INTO trivia_question_leaderboards (trivia_question_id, points, person_id, created_at, updated_at )
    SELECT
      trivia_question_id,
      CASE
        WHEN points >= 0 THEN points
        ELSE 0
      END,
      person_id,
      created_at,
      updated_at
    FROM (
      SELECT
        NULL as id,
        q.id as trivia_question_id,
        r.complexity * (r.leaderboard_size - ROW_NUMBER () OVER (ORDER BY a.time)) as points,
        a.person_id, NOW() AS created_at, NOW() as updated_at
      FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
      WHERE q.id  = $1 AND a.is_correct = 't'
    ) AS leaderboard;
    SELECT pg_notify('leaderboard',  CONCAT('{"type": "question", "id": ', $1 ,'}'));
  END;
$$
LANGUAGE plpgsql;
    )
  end

  def down
    execute %Q( DROP FUNCTION compute_trivia_question_leaderboard(integer); )
  end
end
