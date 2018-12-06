class SetActionTypeIDtoNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :badges, :action_type_id, true, 1
  end
end
