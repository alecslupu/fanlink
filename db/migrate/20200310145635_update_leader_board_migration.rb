class UpdateLeaderBoardMigration < ActiveRecord::Migration[5.1]
  def up

    execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_question_leaderboard(question_id integer)
RETURNS void AS $$
  BEGIN
    -- Select the questions in round
    INSERT INTO trivia_question_leaderboards (trivia_question_id, points, person_id, created_at, updated_at, product_id )
      SELECT
        MAX(trivia_question_id) trivia_question_id,
        MAX(CASE
          WHEN points >= 0 THEN points
          ELSE 0
        END) points,
        person_id,
        NOW() AS created_at,
        NOW() as updated_at,
        MAX(product_id) product_id
      FROM (
        SELECT
          q.id as trivia_question_id,
          r.complexity * (ROW_NUMBER () OVER (ORDER BY COUNT(a.id) ASC, AVG(a.time) DESC)) as points,
          a.person_id,
          q.product_id
        FROM trivia_questions q
          INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
          INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
        WHERE q.id  = $1 AND a.is_correct = 't'
        GROUP BY q.id, r.complexity, a.person_id, q.product_id
      ) AS leaderboard
      GROUP BY person_id
      ORDER by points desc
    ON CONFLICT (trivia_question_id ,person_id)
    DO UPDATE SET points = excluded.points;
  END;
$$
LANGUAGE plpgsql;
    )


    execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_round_leaderboard(round_id integer)
RETURNS void AS $$
  BEGIN
    INSERT INTO trivia_round_leaderboards (trivia_round_id, points, position, person_id, average_time, created_at, updated_at, product_id )
    SELECT
      trivia_round_id,
      points,
      position,
      person_id,
      average_time,
      NOW() AS created_at,
      NOW() as updated_at,
      product_id
    FROM (
      SELECT
        q.trivia_round_id,
        SUM(l.points) as points,
        ROW_NUMBER () OVER (ORDER BY SUM(l.points) DESC, AVG(a.time) DESC) as position,
        a.person_id,
        AVG(a.time) as average_time,
        r.product_id
      FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
        INNER JOIN trivia_question_leaderboards l ON (l.trivia_question_id = a.trivia_question_id)
      WHERE q.trivia_round_id  = $1 AND a.is_correct = 't'
      GROUP BY q.trivia_round_id,r.product_id,r.complexity, r.leaderboard_size, a.person_id
    ) AS leaderboard
    ON CONFLICT (trivia_round_id ,person_id)
    DO UPDATE SET points = excluded.points, position = excluded.position, average_time = excluded.average_time;
  END;
$$
LANGUAGE plpgsql;
)
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
          SUM(l.points) as points,
          ROW_NUMBER () OVER (ORDER BY SUM(l.points) DESC, AVG(a.time) DESC) as position,
          a.person_id,
          AVG(a.time) as average_time,
          NOW() AS created_at, NOW() as updated_at,
          r.product_id
        FROM trivia_questions q
          INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
          INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
          INNER JOIN trivia_round_leaderboards l ON (l.trivia_round_id = q.trivia_round_id )
        WHERE r.trivia_game_id  = $1 AND a.is_correct = 't'
        GROUP BY r.trivia_game_id, r.product_id,  a.person_id
      ) AS leaderboard
    ON CONFLICT (trivia_game_id ,person_id)
    DO UPDATE SET points = excluded.points;
  END;
$$
LANGUAGE plpgsql;
)
  end

  def down

    execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_question_leaderboard(question_id integer)
RETURNS void AS $$
  BEGIN
    -- Select the questions in round
    INSERT INTO trivia_question_leaderboards (trivia_question_id, points, person_id, created_at, updated_at, product_id )
      SELECT
        MAX(trivia_question_id) trivia_question_id,
        MAX(CASE
          WHEN points >= 0 THEN points
          ELSE 0
        END) points,
        person_id,
        NOW() AS created_at,
        NOW() as updated_at,
        MAX(product_id) product_id
      FROM (
        SELECT
          q.id as trivia_question_id,
          r.complexity * (ROW_NUMBER () OVER (ORDER BY COUNT(a.id) ASC, AVG(a.time) DESC)) as points,
          a.person_id,
          q.product_id
        FROM trivia_questions q
          INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
          INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
        WHERE q.id  = $1 AND a.is_correct = 't'
        GROUP BY q.id, r.complexity, a.person_id, q.product_id
      ) AS leaderboard
      GROUP BY person_id
      ORDER by points desc
    ON CONFLICT (trivia_question_id ,person_id)
    DO UPDATE SET points = excluded.points;
    PERFORM pg_notify('leaderboard',  CONCAT('{"type": "question", "id": ', $1 ,'}'));
  END;
$$
LANGUAGE plpgsql;
    )


    execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_round_leaderboard(round_id integer)
RETURNS void AS $$
  BEGIN
    INSERT INTO trivia_round_leaderboards (trivia_round_id, points, position, person_id, average_time, created_at, updated_at, product_id )
    SELECT
      trivia_round_id,
      points,
      position,
      person_id,
      average_time,
      NOW() AS created_at,
      NOW() as updated_at,
      product_id
    FROM (
      SELECT
        q.trivia_round_id,
        SUM(l.points) as points,
        ROW_NUMBER () OVER (ORDER BY SUM(l.points) DESC, AVG(a.time) DESC) as position,
        a.person_id,
        AVG(a.time) as average_time,
        r.product_id
      FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
        INNER JOIN trivia_question_leaderboards l ON (l.trivia_question_id = a.trivia_question_id)
      WHERE q.trivia_round_id  = $1 AND a.is_correct = 't'
      GROUP BY q.trivia_round_id,r.product_id,r.complexity, r.leaderboard_size, a.person_id
    ) AS leaderboard
    ON CONFLICT (trivia_round_id ,person_id)
    DO UPDATE SET points = excluded.points, position = excluded.position, average_time = excluded.average_time;
    PERFORM pg_notify('leaderboard',  CONCAT('{"type": "round", "id": ', $1 ,'}'));
  END;
$$
LANGUAGE plpgsql;
)
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
          SUM(l.points) as points,
          ROW_NUMBER () OVER (ORDER BY SUM(l.points) DESC, AVG(a.time) DESC) as position,
          a.person_id,
          AVG(a.time) as average_time,
          NOW() AS created_at, NOW() as updated_at,
          r.product_id
        FROM trivia_questions q
          INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
          INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
          INNER JOIN trivia_round_leaderboards l ON (l.trivia_round_id = q.trivia_round_id )
        WHERE r.trivia_game_id  = $1 AND a.is_correct = 't'
        GROUP BY r.trivia_game_id, r.product_id,  a.person_id
      ) AS leaderboard
    ON CONFLICT (trivia_game_id ,person_id)
    DO UPDATE SET points = excluded.points;
    PERFORM pg_notify('leaderboard',  CONCAT('{"type": "game", "id": ', $1 ,'}'));
  END;
$$
LANGUAGE plpgsql;
)
  end
end
