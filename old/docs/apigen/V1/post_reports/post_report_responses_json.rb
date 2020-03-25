class AddPostReportJsonResponse < Apigen::Migration
  def up
    add_model :post_report_response do
      type :object do
        id :string?
        created_at :string?
        post_id :int32?
        poster :string?
        reporter :string?
        reason :string?
        status :string?
      end
    end
  end
end
