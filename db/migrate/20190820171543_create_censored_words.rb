class CreateCensoredWords < ActiveRecord::Migration[5.1]
  def change
    create_table :censored_words do |t|
      t.string :word

      t.timestamps
    end
  end
end
