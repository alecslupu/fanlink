class CreateMessageReports < ActiveRecord::Migration[5.1]
  def change
    create_table :message_reports do |t|
      t.integer :message_id, null: false
      t.integer :person_id, null: false
      t.text :reason, null: false
      t.integer :status, default: 0, null: false
      t.timestamps null: false
    end
    add_foreign_key :message_reports, :messages, name: "fk_message_reports_message", on_delete: :cascade
  end
end
