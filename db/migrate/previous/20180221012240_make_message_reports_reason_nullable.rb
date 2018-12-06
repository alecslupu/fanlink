class MakeMessageReportsReasonNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :message_reports, :reason, true
  end
end
