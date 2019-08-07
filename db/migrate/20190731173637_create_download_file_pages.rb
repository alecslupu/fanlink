class CreateDownloadFilePages < ActiveRecord::Migration[5.1]
  def change
    create_table :download_file_pages do |t|
      t.belongs_to :certcourse_page, foreign_key: true
      t.belongs_to :product, foreign_key: true
      t.attachment :document

      t.timestamps
    end
  end
end
