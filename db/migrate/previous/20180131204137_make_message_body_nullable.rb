class MakeMessageBodyNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :messages, :body, true
  end
end
