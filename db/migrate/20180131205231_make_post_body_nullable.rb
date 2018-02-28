class MakePostBodyNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :posts, :body, true
  end
end
