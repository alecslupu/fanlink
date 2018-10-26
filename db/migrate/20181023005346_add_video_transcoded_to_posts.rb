class AddVideoTranscodedToPosts < ActiveRecord::Migration[5.1]
  change_table :posts do |t|
    t.jsonb :video_transcoded, default: {}, null: false
  end
end
