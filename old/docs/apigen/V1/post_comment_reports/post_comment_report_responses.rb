class AddPostCommentReportJsonResponse < Apigen::Migration
  def up
    add_model :post_comment_report_response do
      type :object do
        id :string?
        created_at :string?
        post_comment_id :int32?
        commenter :string?
        reporter :string?
        reason :string?
        status :string?
      end
    end
  end
end