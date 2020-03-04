class ChangeTriviaLeaderBoardsTables < ActiveRecord::Migration[5.1]
  def up

    execute %Q(TRUNCATE TABLE trivia_question_leaderboards)
    execute %Q(TRUNCATE TABLE trivia_round_leaderboards)
    execute %Q(TRUNCATE TABLE trivia_game_leaderboards)

    add_index :trivia_question_leaderboards,  [:trivia_question_id, :person_id], unique: true, name: :idx_uniq_tql_tqid_pid
    add_index :trivia_round_leaderboards,  [:trivia_round_id, :person_id], unique: true, name: :idx_uniq_trl_trid_pid
    add_index :trivia_game_leaderboards,  [:trivia_game_id, :person_id], unique: true, name: :idx_uniq_tgl_tgid_pid

    execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_question_leaderboard(question_id integer)
RETURNS void AS $$
  BEGIN
    -- Select the questions in round
    INSERT INTO trivia_question_leaderboards (trivia_question_id, points, person_id, created_at, updated_at, product_id )
      SELECT
        trivia_question_id,
        CASE
          WHEN points >= 0 THEN points
          ELSE 0
        END,
        person_id,
        created_at,
        updated_at,
        product_id
      FROM (
        SELECT
          NULL as id,
          q.id as trivia_question_id,
          r.complexity * (r.leaderboard_size - ROW_NUMBER () OVER (ORDER BY a.time)) as points,
          a.person_id, NOW() AS created_at, NOW() as updated_at,
          q.product_id
        FROM trivia_questions q
          INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
          INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
        WHERE q.id  = $1 AND a.is_correct = 't'
      ) AS leaderboard
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
        q.trivia_round_id,
        r.complexity * ( r.leaderboard_size - ROW_NUMBER () OVER (ORDER BY AVG(a.time))) as points,
        ROW_NUMBER () OVER (ORDER BY AVG(a.time)) as position,
        a.person_id,
        AVG(a.time) as average_time,
        NOW() AS created_at, NOW() as updated_at,
        r.product_id
      FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
      WHERE q.trivia_round_id  = $1 AND a.is_correct = 't'
      GROUP BY q.trivia_round_id,r.product_id,r.complexity, r.leaderboard_size, a.person_id
    ) AS leaderboard
    ON CONFLICT (trivia_round_id ,person_id)
    DO UPDATE SET points = excluded.points;
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
        GROUP BY r.trivia_game_id, r.product_id,r.complexity, r.leaderboard_size, a.person_id
      ) AS leaderboard
    ON CONFLICT (trivia_game_id ,person_id)
    DO UPDATE SET points = excluded.points;
    PERFORM pg_notify('leaderboard',  CONCAT('{"type": "game", "id": ', $1 ,'}'));
  END;
$$
LANGUAGE plpgsql;)
  end

  def down
    remove_index :trivia_question_leaderboards, name: :idx_uniq_tql_tqid_pid
    remove_index :trivia_round_leaderboards, name: :idx_uniq_trl_trid_pid
    remove_index :trivia_game_leaderboards, name: :idx_uniq_tgl_tgid_pid

    execute %Q(
CREATE OR REPLACE FUNCTION compute_trivia_question_leaderboard(question_id integer)
RETURNS void AS $$
  BEGIN
    -- Select the questions in round
    INSERT INTO trivia_question_leaderboards (trivia_question_id, points, person_id, created_at, updated_at, product_id )
    SELECT
      trivia_question_id,
      CASE
        WHEN points >= 0 THEN points
        ELSE 0
      END,
      person_id,
      created_at,
      updated_at,
      product_id
    FROM (
      SELECT
        NULL as id,
        q.id as trivia_question_id,
        r.complexity * (r.leaderboard_size - ROW_NUMBER () OVER (ORDER BY a.time)) as points,
        a.person_id, NOW() AS created_at, NOW() as updated_at,
        q.product_id
      FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
      WHERE q.id  = $1 AND a.is_correct = 't'
    ) AS leaderboard;
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
        q.trivia_round_id,
        r.complexity * ( r.leaderboard_size - ROW_NUMBER () OVER (ORDER BY AVG(a.time))) as points,
        ROW_NUMBER () OVER (ORDER BY AVG(a.time)) as position,
        a.person_id,
        AVG(a.time) as average_time,
        NOW() AS created_at, NOW() as updated_at,
        r.product_id
      FROM trivia_questions q
        INNER JOIN trivia_answers a ON (q.id = a.trivia_question_id )
        INNER JOIN trivia_rounds r ON (q.trivia_round_id = r.id )
      WHERE q.trivia_round_id  = $1 AND a.is_correct = 't'
      GROUP BY q.trivia_round_id,r.product_id,r.complexity, r.leaderboard_size, a.person_id
    ) AS leaderboard;
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
      GROUP BY r.trivia_game_id, r.product_id,r.complexity, r.leaderboard_size, a.person_id
    ) AS leaderboard;
    PERFORM pg_notify('leaderboard',  CONCAT('{"type": "game", "id": ', $1 ,'}'));
  END;
$$
LANGUAGE plpgsql;)
  end
end
