class CreateCensoredWords < ActiveRecord::Migration[5.1]
  def self.up
    unless table_exists? :censored_words
      create_table :censored_words do |t|
        t.string :word

        t.timestamps
      end
    end
  end
  def self.down
    drop_table :censored_words
  end
end
