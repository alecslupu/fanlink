class SorceryExternal < ActiveRecord::Migration[5.1]
  def up
    create_table  :authentications do |t|
      t.integer   :person_id,       null: false
      t.string    :provider, :uid,  null: false

      t.timestamps                  null: false
    end
    add_index :authentications, [:provider, :uid], name: "ind_authentications_provider_uid"
    add_foreign_key :authentications, :people, name: "fk_authentications_people"
  end

  def down
    drop_table :authentications
  end
end
