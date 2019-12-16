require "rails_helper"

RSpec.describe Api::V4::PostsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    it 'returns all the posts with the attachments' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        person2 = create(:person)
        login_as(person)
        from = Date.today - 1.day
        to = Date.today
        person.follow(person2)
        person2.follow(person)
        create_list(
          :published_post,
          3,
          person: person2,
          body: "this is my body",
          picture: fixture_file_upload('images/better.png', 'image/png'),
          audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4'),
          video: fixture_file_upload('videos/short_video.mp4', 'video/mp4'),
          created_at: to
        )
        get :index,
          params: {
            from_date: from,
            to_date: to
          }

        expect(response).to be_successful
        expect(json['posts'].size).to eq(3)
        json['posts'].each do |post|
          expect(post['picture_url']).not_to eq(nil)
          expect(post['audio_url']).not_to eq(nil)
          expect(post['video_url']).not_to eq(nil)
        end
      end
    end

    it 'returns all the posts with the attachments' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        person2 = create(:person)
        login_as(person)
        person.follow(person2)
        person2.follow(person)
        poll = create(:poll)
        poll.post.update(person_id: person2.id, status: :published)

        get :index, params: {
          promoted: true
        }
        json['posts'].each do |post|
          expect(post['picture_url']).not_to eq(nil)
          expect(post['audio_url']).not_to eq(nil)
          expect(post['video_url']).not_to eq(nil)
        end
      end
    end
  end

  # TODO: auto-generated
  describe "GET list" do
    it 'returns all the posts with the attachments' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        person2 = create(:person)
        login_as(person)
        from = Date.today - 1.day
        to = Date.today
        person.follow(person2)
        person2.follow(person)
        create_list(
          :published_post,
          3,
          person: person2,
          body: "this is my body",
          picture: fixture_file_upload('images/better.png', 'image/png'),
          audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4'),
          video: fixture_file_upload('videos/short_video.mp4', 'video/mp4'),
          created_at: to
        )
        get :list

        expect(response).to be_successful
        expect(json['posts'].size).to eq(3)
        json['posts'].each do |post|
          expect(post['picture_url']).not_to eq(nil)
          expect(post['audio_url']).not_to eq(nil)
          expect(post['video_url']).not_to eq(nil)
        end
      end
    end

    it 'returns all poll data' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        person2 = create(:person)
        login_as(person)
        person.follow(person2)
        person2.follow(person)
        poll = create(:poll)
        post = poll.post
        post.update(person_id: person2.id, status: :published)

        get :show, params: { id: post.id }

        expect(response).to be_successful
        expect(json["post"]["poll"]["id"]).not_to eq(nil)
        expect(json["post"]["poll"]["type"]).not_to eq(nil)
        expect(json["post"]["poll"]["type_id"]).not_to eq(nil)
        expect(json["post"]["poll"]["description"]).not_to eq(nil)
        expect(json["post"]["poll"]["start_date"]).not_to eq(nil)
        expect(json["post"]["poll"]["duration"]).not_to eq(nil)
        expect(json["post"]["poll"]["end_date"]).not_to eq(nil)
        expect(json["post"]["poll"]["create_time"]).not_to eq(nil)
        expect(json["post"]["poll"]["closed"]).not_to eq(nil)

      end
    end



  end

  # TODO: auto-generated
  describe "GET promoted" do
  end

  # TODO: auto-generated
  describe "GET show" do
    it 'returns the message with the attachments' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post = create(
          :published_post,
          body: "this is my body",
          picture: fixture_file_upload('images/better.png', 'image/png'),
          audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4'),
          video: fixture_file_upload('videos/short_video.mp4', 'video/mp4')
        )
        get :show, params: { id: post.id }

        expect(response).to be_successful
        expect(json['post']['picture_url']).not_to eq(nil)
        expect(json['post']['audio_url']).not_to eq(nil)
        expect(json['post']['video_url']).not_to eq(nil)
      end
    end
  end

  # TODO: auto-generated
  describe "GET share" do
    it 'returns all the posts with the attachments' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        person2 = create(:person)
        login_as(person)
        from = Date.today - 1.day
        to = Date.today
        person.follow(person2)
        person2.follow(person)
        post = create(
          :published_post,
          body: "this is my body",
          picture: fixture_file_upload('images/better.png', 'image/png'),
        )

        get :share, params: { post_id: post.id, product: person.product.internal_name }

        expect(response).to be_successful
        expect(json['post']['picture_url']).not_to eq(nil)
      end
    end
  end

  # TODO: auto-generated
  describe "POST create" do
    it "creates a post with attachments when it's valid" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        post :create, params: {
          post: {
            body: "Body",
            picture: fixture_file_upload('images/better.png', 'image/png'),
            audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4'),
            video: fixture_file_upload('videos/short_video.mp4', 'video/mp4')
          }
        }

        expect(response).to be_successful
        expect(Post.last.picture.exists?).to be_truthy
        expect(Post.last.audio.exists?).to be_truthy
        expect(Post.last.video.exists?).to be_truthy
        expect(json['post']['picture_url']).to include('better.png')
        expect(json['post']['audio_url']).to include('small_audio')
        expect(json['post']['video_url']).to include('short_video')
      end
    end
  end

  # TODO: auto-generated
  describe "PUT update" do
    it "updates a posts with attachments when it's valid" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post = create(:post)

        put :update,
          params: {
            id: post.id,
            post: {
              picture: fixture_file_upload('images/better.png', 'image/png'),
              audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4'),
              video: fixture_file_upload('videos/short_video.mp4', 'video/mp4')
            }
          }

        expect(response).to be_successful
        expect(Post.last.picture.exists?).to be_truthy
        expect(Post.last.audio.exists?).to be_truthy
        expect(Post.last.video.exists?).to be_truthy
        expect(json['post']['picture_url']).to include('better.png')
        expect(json['post']['audio_url']).to include('small_audio')
        expect(json['post']['video_url']).to include('short_video')
      end
    end


    it 'returns all the posts with the attachments' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        person2 = create(:person)
        login_as(person)
        person.follow(person2)
        person2.follow(person)
        poll = create(:poll)
        post = poll.post
        post.update(person_id: person2.id, status: :published)

        patch :update, params: { id: post.id, post: { recommended: true}  }

        expect(response).to be_successful

        poll = json["post"]["poll"]

        expect(poll["id"]).not_to eq(nil)
        expect(poll["type"]).not_to eq(nil)
        expect(poll["type_id"]).not_to eq(nil)
        expect(poll["description"]).not_to eq(nil)
        expect(poll["start_date"]).not_to eq(nil)
        expect(poll["duration"]).not_to eq(nil)
        expect(poll["end_date"]).not_to eq(nil)
        expect(poll["create_time"]).not_to eq(nil)
        expect(poll["closed"]).not_to eq(nil)

      end
    end

    it 'returns all poll data' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        person2 = create(:person)
        login_as(person)
        person.follow(person2)
        person2.follow(person)
        poll = create(:poll)
        post = poll.post
        post.update(person_id: person2.id, status: :published)

        get :show, params: { id: post.id }

        expect(response).to be_successful
        expect(json["post"]["poll"]["id"]).not_to eq(nil)
        expect(json["post"]["poll"]["type"]).not_to eq(nil)
        expect(json["post"]["poll"]["type_id"]).not_to eq(nil)
        expect(json["post"]["poll"]["description"]).not_to eq(nil)
        expect(json["post"]["poll"]["start_date"]).not_to eq(nil)
        expect(json["post"]["poll"]["duration"]).not_to eq(nil)
        expect(json["post"]["poll"]["end_date"]).not_to eq(nil)
        expect(json["post"]["poll"]["create_time"]).not_to eq(nil)
        expect(json["post"]["poll"]["closed"]).not_to eq(nil)

      end
    end
  end

  # TODO: auto-generated
  describe "GET stats" do
    pending
  end
end
