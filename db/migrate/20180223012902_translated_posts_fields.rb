class TranslatedPostsFields < ActiveRecord::Migration[5.1]
  def up
    remove_column :posts, :title
    rename_column :posts, :body, :body_text_old
    add_column :posts, :body, :jsonb

    Post.all.each do |p|
      p.body = p.body_text_old
      p.save
    end
  end

  def down
    add_column :posts, :title, :text
    remove_column :posts, :body
    rename_column :posts, :body_text_old, :body
  end
end
