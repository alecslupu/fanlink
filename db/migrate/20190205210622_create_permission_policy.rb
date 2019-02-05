class CreatePermissionPolicy < ActiveRecord::Migration[5.1]
  def change
    create_table :permission_policies do |t|
      t.integer :action, null: false, default: 0
      t.integer :badge, null: false, default: 0
      t.integer :category, null: false, default: 0
      t.integer :event, null: false, default: 0
      t.integer :interest, null: false, default: 0
      t.integer :level, null: false, default: 0
      t.integer :merchandise, null: false, default: 0
      t.integer :message, null: false, default: 0
      t.integer :people, null: false, default: 0
      t.integer :poll, null: false, default: 0
      t.integer :portal_notification, null: false, default: 0
      t.integer :post, null: false, default: 0
      t.integer :product_beacon, null: false, default: 0
      t.integer :product, null: false, default: 0
      t.integer :quest, null: false, default: 0
      t.integer :reward, null: false, default: 0
      t.integer :room, null: false, default: 0
      t.integer :education, null: false, default: 0
    end
  end
end
