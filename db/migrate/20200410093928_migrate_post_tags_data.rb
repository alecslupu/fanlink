class MigratePostTagsData < ActiveRecord::Migration[5.2]
  def up
    if Post.respond_to?(:old_tags)
      Post.find_each do |post|
        post.old_tags.find_each do |t|
          post.tag_list.add(t.name)
        end
        post.save
      end
    end
  end
end
