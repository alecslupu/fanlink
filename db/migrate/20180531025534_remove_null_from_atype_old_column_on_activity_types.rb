class RemoveNullFromAtypeOldColumnOnActivityTypes < ActiveRecord::Migration[5.1]
  def change
    change_column_null :activity_types, :atype_old, true
  end
end
