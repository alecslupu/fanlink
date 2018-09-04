FanlinkApi::API.model :post_app_json do
  type :object do
    post :object do
      id :int32
      person_id :int32
      global :bool
      starts_at :string
      ends_at :string
      repost_interval :int32
      status :int32
      created_at :string
      updated_at :string
      picture_file_name :string
      picture_content_type :string
      picture_file_size :int32
      picture_updated_at :string
      body :string
      priority :int32
      recommended :bool
      notify_followers :bool
      audio_file_name :string
      audio_content_type :string
      audio_file_size :int32
      audio_updated_at :string
      category_id :int32
    end
  end
end
