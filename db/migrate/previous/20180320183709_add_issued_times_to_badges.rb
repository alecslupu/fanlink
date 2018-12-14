class AddIssuedTimesToBadges < ActiveRecord::Migration[5.1]
  def change
    add_column :badges, :issued_from, :datetime
    add_column :badges, :issued_to, :datetime
    add_index :badges, %i[ issued_from ], name: "ind_badges_issued_from"
    add_index :badges, %i[ issued_to ], name: "ind_badges_issued_to"
  end
end
