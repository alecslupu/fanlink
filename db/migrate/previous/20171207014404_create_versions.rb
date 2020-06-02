# This migration creates the `versions` table, the only schema PT requires.
# All other migrations PT provides are optional.
class CreateVersions < ActiveRecord::Migration[5.1]
  # The largest text column available in all supported RDBMS is
  # 1024^3 - 1 bytes, roughly one gibibyte.  We specify a size
  # so that MySQL will use `longtext` instead of `text`.  Otherwise,
  # when serializing very large objects, `text` might not be big enough.
  TEXT_BYTES = 1_073_741_823

  def up
    create_table :versions do |t|
      t.text    :item_type, null: false
      t.integer :item_id,   null: false
      t.text    :event,     null: false
      t.text    :whodunnit
      t.text    :object,    limit: TEXT_BYTES

      t.datetime :created_at
    end
    add_index :versions, %i(item_type item_id), name: "ind_versions_item_type_item_id"
  end

  def down
    drop_table :versions
  end
end
