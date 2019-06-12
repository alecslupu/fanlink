class ChangeTriviaGameLeaderboardFunction < ActiveRecord::Migration[5.1]
  def up
    execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_game_leaderboard(game_id integer)
RETURNS void AS $$
  BEGIN
    INSERT INTO trivia_game_leaderboards (trivia_game_id, points, position, person_id, average_time, created_at, updated_at, product_id )
    SELECT
      trivia_game_id,
      CASE
        WHEN points >= 0 THEN points
        ELSE 0
      END,
      position,
      person_id,
      average_time,
      created_at,
      updated_at,
      product_id
    FROM (
      SELECT
        r.trivia_game_id,
        r.complexity * ( r.leaderboard_size - ROW_NUMBER () OVER (ORDER BY AVG(a.time))) as points,
        ROW_NUMBER () OVER (ORDER BY AVG(a.time)) as position,
        a.person_id,
        AVG(a.time) as average_time,
        NOW() AS created_at, NOW() as updated_at,
        r.product_id
      FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
      WHERE r.trivia_game_id  = $1 AND a.is_correct = 't'
      GROUP BY r.trivia_game_id,r.complexity, r.leaderboard_size, a.person_id
    ) AS leaderboard;
    PERFORM pg_notify('leaderboard',  CONCAT('{"type": "game", "id": ', $1 ,'}'));
  END;
$$
LANGUAGE plpgsql;)
  end
  def down

    execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_game_leaderboard(game_id integer)
RETURNS void AS $$
  BEGIN
    INSERT INTO trivia_game_leaderboards (trivia_game_id, points, position, person_id, average_time, created_at, updated_at )
    SELECT
      trivia_game_id,
      CASE
        WHEN points >= 0 THEN points
        ELSE 0
      END,
      position,
      person_id,
      average_time,
      created_at,
      updated_at
    FROM (
      SELECT
        r.trivia_game_id,
        r.complexity * ( r.leaderboard_size - ROW_NUMBER () OVER (ORDER BY AVG(a.time))) as points,
        ROW_NUMBER () OVER (ORDER BY AVG(a.time)) as position,
        a.person_id,
        AVG(a.time) as average_time,
        NOW() AS created_at, NOW() as updated_at
      FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
      WHERE r.trivia_game_id  = $1 AND a.is_correct = 't'
      GROUP BY r.trivia_game_id,r.complexity, r.leaderboard_size, a.person_id
    ) AS leaderboard;
    PERFORM pg_notify('leaderboard',  CONCAT('{"type": "game", "id": ', $1 ,'}'));
  END;
$$
LANGUAGE plpgsql;)
  end
end
