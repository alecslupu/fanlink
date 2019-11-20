class AddProductToTrivia < ActiveRecord::Migration[5.1]
  def change

    product = Product.find_by(internal_name: "caned")

    if product.nil?
      add_column :trivia_answers, :product_id, :integer, null: false
      add_column :trivia_available_answers, :product_id, :integer, null: false
      add_column :trivia_available_questions, :product_id, :integer, null: false
      add_column :trivia_questions, :product_id, :integer, null: false
      add_column :trivia_prizes, :product_id, :integer, null: false
      add_column :trivia_question_leaderboards, :product_id, :integer, null: false
      add_column :trivia_rounds, :product_id, :integer, null: false
      add_column :trivia_round_leaderboards, :product_id, :integer, null: false
      add_column :trivia_subscribers, :product_id, :integer, null: false
      add_column :trivia_game_leaderboards, :product_id, :integer, null: false
      add_column :trivia_topics, :product_id, :integer, null: false
      add_column :trivia_picture_available_answers, :product_id, :integer, null: false
    else
      add_column :trivia_answers, :product_id, :integer, null: false, default: product.id
      add_column :trivia_available_answers, :product_id, :integer, null: false, default: product.id
      add_column :trivia_available_questions, :product_id, :integer, null: false, default: product.id
      add_column :trivia_questions, :product_id, :integer, null: false, default: product.id
      add_column :trivia_prizes, :product_id, :integer, null: false, default: product.id
      add_column :trivia_question_leaderboards, :product_id, :integer, null: false, default: product.id
      add_column :trivia_rounds, :product_id, :integer, null: false, default: product.id
      add_column :trivia_round_leaderboards, :product_id, :integer, null: false, default: product.id
      add_column :trivia_subscribers, :product_id, :integer, null: false, default: product.id
      add_column :trivia_game_leaderboards, :product_id, :integer, null: false, default: product.id
      add_column :trivia_topics, :product_id, :integer, null: false, default: product.id
      add_column :trivia_picture_available_answers, :product_id, :integer, null: false, default: product.id

      change_column_default :trivia_answers, :product_id, nil
      change_column_default :trivia_available_answers, :product_id, nil
      change_column_default :trivia_available_questions, :product_id, nil
      change_column_default :trivia_questions, :product_id, nil
      change_column_default :trivia_prizes, :product_id, nil
      change_column_default :trivia_question_leaderboards, :product_id, nil
      change_column_default :trivia_rounds, :product_id, nil
      change_column_default :trivia_round_leaderboards, :product_id, nil
      change_column_default :trivia_subscribers, :product_id, nil
      change_column_default :trivia_game_leaderboards, :product_id, nil
      change_column_default :trivia_topics, :product_id, nil
      change_column_default :trivia_picture_available_answers, :product_id, nil
    end

    add_foreign_key :trivia_answers, :products, name: "fk_trivia_answers_products", on_delete: :cascade
    add_index :trivia_answers, %i[ product_id ], name: "idx_trivia_answers_product"

    add_foreign_key :trivia_available_answers, :products, name: "fk_trivia_available_answers_products", on_delete: :cascade
    add_index :trivia_available_answers, %i[ product_id ], name: "idx_trivia_available_answers_product"

    add_foreign_key :trivia_available_questions, :products, name: "fk_trivia_available_questions_products", on_delete: :cascade
    add_index :trivia_available_questions, %i[ product_id ], name: "idx_trivia_available_questions_product"

    add_foreign_key :trivia_questions, :products, name: "fk_trivia_questions_products", on_delete: :cascade
    add_index :trivia_questions, %i[ product_id ], name: "idx_trivia_questions_product"

    add_foreign_key :trivia_prizes, :products, name: "fk_trivia_prizes_products", on_delete: :cascade
    add_index :trivia_prizes, %i[ product_id ], name: "idx_trivia_prizes_product"

    add_foreign_key :trivia_question_leaderboards, :products, name: "fk_trivia_question_leaderboards_products", on_delete: :cascade
    add_index :trivia_question_leaderboards, %i[ product_id ], name: "idx_trivia_question_leaderboards_product"

    add_foreign_key :trivia_rounds, :products, name: "fk_trivia_rounds_products", on_delete: :cascade
    add_index :trivia_rounds, %i[ product_id ], name: "idx_trivia_rounds_product"

    add_foreign_key :trivia_round_leaderboards, :products, name: "fk_trivia_round_leaderboards_products", on_delete: :cascade
    add_index :trivia_round_leaderboards, %i[ product_id ], name: "idx_trivia_round_leaderboards_product"

    add_foreign_key :trivia_subscribers, :products, name: "fk_trivia_subscribers_products", on_delete: :cascade
    add_index :trivia_subscribers, %i[ product_id ], name: "idx_trivia_subscribers_product"

    add_foreign_key :trivia_game_leaderboards, :products, name: "fk_trivia_game_leaderboards_products", on_delete: :cascade
    add_index :trivia_game_leaderboards, %i[ product_id ], name: "idx_trivia_game_leaderboards_product"

    add_foreign_key :trivia_topics, :products, name: "fk_trivia_topics_products", on_delete: :cascade
    add_index :trivia_topics, %i[ product_id ], name: "idx_trivia_topics_product"

    add_foreign_key :trivia_picture_available_answers, :products, name: "fk_trivia_picture_available_answers_products", on_delete: :cascade
    add_index :trivia_picture_available_answers, %i[ product_id ], name: "idx_trivia_picture_available_answers_product"
  end
end
