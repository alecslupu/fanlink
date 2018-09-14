class CreateHackedMetrics < ActiveRecord::Migration[5.1]
  def change
    create_table :hacked_metrics do |t|
      t.integer :product_id, null: false
      t.integer :person_id, null: false
      t.integer :action_type_id, null: false
      t.integer :identifier
      t.timestamps null: false
    end
    add_index :hacked_metrics, :product_id, name: "idx_hacked_metrics_product"
    add_index :hacked_metrics, :person_id, name: "idx_hacked_metrics_person"
    add_index :hacked_metrics, :action_type_id, name: "idx_hacked_metrics_activity_type"
  end
end
