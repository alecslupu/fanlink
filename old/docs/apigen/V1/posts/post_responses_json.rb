class AddPostJsonResponse < Apigen::Migration
  def up
    add_model :post_response do
      type :object do
        id :string
        created_time :string?
        body :string?
        picture_url :string?
        audio_url :string?
        audio_content_type :string?
        audio_file_size :int32?
        person :person_response?
        post_reaction_counts :object? do
          emoji :int32?
        end
        post_reaction :post_reaction_response?
        global :bool?
        starts_at :string?
        ends_at :string?
        repost_interval :int32?
        status :string?
        priority :int32?
        recommended :bool?
        notify_followers :bool?
        comment_count :int32?
        category :object? do
          id :int32?
          name :string?
          color :string?
          role :string?
        end
        tags :array? do
          type :object do
            name :string?
          end
        end
      end
    end

    add_model :post_list_response do
      type :object do
        id :string
        person :person_response?
        body :string?
        picture_url :string?
        global :bool?
        starts_at :string?
        ends_at :string?
        repost_interval :int32?
        status :string?
        priority :int32?
        recommended :bool?
        created_at :string?
        comment_count :int32?
        category :object? do
          id :int32?
          name :string?
          color :string?
          role :string?
        end
        tags :array? do
          type :object do
            name :string?
          end
        end
      end
    end

    add_model :post_share_response do
      type :object do
        body :string?
        picture_url :string?
        person :object? do
          username :string?
          picture_url :string?
        end
      end
    end
  end
end
