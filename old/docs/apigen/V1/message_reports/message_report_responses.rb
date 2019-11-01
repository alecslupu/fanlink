class AddMessageReportJsonResponse < Apigen::Migration
  def up
    add_model :message_report_response do
      type :object do
        id :string?
        message_id :int32?
        poster :string?
        reporter :string?
        reason :string?
        status :string?
        created_at :datetime?
        updated_at :datetime?
      end
    end
  end
end
