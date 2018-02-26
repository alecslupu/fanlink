class TranslatedPostsFields < ActiveRecord::Migration[5.1]
  def up
    rename_column :posts, :body, :body_text_old
    add_column :posts, :body, :jsonb, default: {}, null: false

    Post.all.each do |p|
      if p.body_text_old.present?
        p.body = p.body_text_old
        p.save
      end
    end
  end

  def down
    remove_column :posts, :body
    rename_column :posts, :body_text_old, :body
  end
end
