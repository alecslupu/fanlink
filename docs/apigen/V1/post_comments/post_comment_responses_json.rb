class AddPostCommentJsonResponse < Apigen::Migration
  def up
    add_model :post_comment_response do
      type :object do
        id :string
        create_time :string
        body :string
        mentions :array? do
          type :mention_response
        end
        person :person_response
      end
    end

    add_model :post_comment_list_response do
      type :object do
        id :string
        post_id :int32
        person_id :int32
        body :string
        hidden :bool
        created_at :string
        updated_at :string
        mentions :array? do
          type :mention_response
        end
      end
    end
  end
end
