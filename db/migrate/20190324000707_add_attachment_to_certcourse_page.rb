class AddAttachmentToCertcoursePage < ActiveRecord::Migration[5.1]
  def up
    add_attachment :certcourse_pages, :attachment
  end

  def down
    remove_attachment :certcourse_pages, :attachment
  end
end
