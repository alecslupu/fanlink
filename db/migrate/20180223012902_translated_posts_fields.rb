class TranslatedPostsFields < ActiveRecord::Migration[5.1]
  def up
    rename_column :posts, :body, :body_text_old
    add_column :posts, :body, :jsonb

    Post.all.each do |p|
      p.body = p.body_text_old
      p.save
    end
  end

  def down
    remove_column :posts, :body
    rename_column :posts, :body_text_old, :body
  end
end
