# frozen_string_literal: true
require "rails_helper"

RSpec.describe Api::V4::PostsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    let(:created_in_range) { Date.parse("2018-01-02").end_of_day }
    let(:from) { "2018-01-01" }
    let(:to) { "2018-01-03" }
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

    it "should get a list of posts for a date range without limit" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        people = create_list(:person, 2)
        person.follow(people.first)
        person.follow(people.last)

        postloggedin = create(:published_post, person: person, created_at: created_in_range + 31.minutes)
        post11 = create(:published_post, person: people.first, created_at: created_in_range - 1.hour)
        post12 = create(:published_post, person: people.first, created_at: created_in_range - 30.minutes)
        post21 = create(:published_post, person: people.last, created_at: created_in_range)
        post22 = create(:published_post, person: people.last, created_at: created_in_range + 30.minutes)
        login_as(person)
        get :index, params: { from_date: from, to_date: to }
        expect(response).to be_successful
        expect(json["posts"].map { |p| p["id"].to_i }).to eq([postloggedin.id, post22.id, post21.id, post12.id, post11.id])
      end
    end


    it "returns a list of posts after the given one in the correct order" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        poster = create(:person)
        person.follow(poster)
        post1 = create(:published_post, person: person, starts_at: 10.hours.ago)
        post2 = create(:published_post, person: person, starts_at: 9.hours.ago)
        post3 = create(:published_post, person: poster, starts_at: 8.hours.ago)
        post4 = create(:published_post, person: person, starts_at: 7.hours.ago)

        get :index,
            params: {
                post_id: post2.id,
                chronologically: 'after'
            }
        expect(response).to be_successful
        expect(json['posts'].size).to eq(2)
        expect(json['posts'].map { |p| p['id'].to_i }).to eq([post3.id, post4.id])
      end
    end

    # it "returns all the room's messages before the given one in the correct order" do
    #   person = create(:admin_user)
    #   ActsAsTenant.with_tenant(person.product) do
    #     login_as(person)
    #     room = create(:room, status: :active, public: true)
    #     msg1 = create(:message, room_id: room.id)
    #     msg2 = create(:message, room_id: room.id)
    #     msg3 = create(:message, room_id: room.id, created_at: DateTime.now + 1)
    #     msg4 = create(:message, room_id: room.id, created_at: DateTime.now + 2)

    #     get :index,
    #       params: {
    #         room_id: room.id,
    #         message_id: msg3.id,
    #         chronologically: 'before'
    #     }

    #     expect(response).to be_successful
    #     expect(json['messages'].size).to eq(2)
    #     expect(json['messages'].map { |m| m['id'] }).to eq([msg2.id, msg1.id])
    #   end
    # end

    # it "returns all the room's pinned messages after the given one in the correct order" do
    #   person = create(:admin_user, pin_messages_from: true)
    #   ActsAsTenant.with_tenant(person.product) do
    #     login_as(person)
    #     room = create(:room, status: :active, public: true)
    #     msg1 = create(:message, room_id: room.id)
    #     msg2 = create(:message, room_id: room.id, created_at: DateTime.now + 1)
    #     msg3 = create(:message, room_id: room.id, created_at: msg2.created_at + 1, person_id: person.id)
    #     msg4 = create(:message, room_id: room.id, created_at: msg2.created_at + 2, person_id: person.id)
    #     msg5 = create(:message, room_id: room.id, created_at: msg2.created_at + 3)

    #     get :index,
    #       params: {
    #         room_id: room.id,
    #         message_id: msg2.id,
    #         chronologically: 'after',
    #         pinned: 'yes'
    #     }

    #     expect(response).to be_successful
    #     expect(json['messages'].size).to eq(2)
    #     expect(json['messages'].map { |m| m['id'] }).to eq([msg3.id, msg4.id])
    #   end
    # end

    # it "returns all the room's pinned messages before the given one" do
    #   person = create(:admin_user, pin_messages_from: true)
    #   ActsAsTenant.with_tenant(person.product) do
    #     login_as(person)
    #     room = create(:room, status: :active, public: true)
    #     msg1 = create(:message, room_id: room.id, person_id: person.id)
    #     msg2 = create(:message, room_id: room.id, person_id: person.id)
    #     msg3 = create(:message, room_id: room.id, created_at: DateTime.now + 1)
    #     msg4 = create(:message, room_id: room.id, created_at: DateTime.now + 2)
    #     msg5 = create(:message, room_id: room.id)

    #     get :index,
    #       params: {
    #         room_id: room.id,
    #         message_id: msg3.id,
    #         chronologically: 'before',
    #         pinned: 'yes'
    #     }

    #     expect(response).to be_successful
    #     expect(json['messages'].size).to eq(2)
    #     expect(json['messages'].map { |m| m['id'] }).to eq([msg2.id, msg1.id])
    #   end
    # end

    # it "returns all the messages from the room if only chronologically param is given" do
    #   person = create(:admin_user)
    #   ActsAsTenant.with_tenant(person.product) do
    #     login_as(person)
    #     room = create(:room, status: :active, public: true)
    #     msg1 = create(:message, room_id: room.id)
    #     msg2 = create(:message, room_id: room.id, created_at: DateTime.now + 2)

    #     get :index,
    #       params: {
    #         room_id: room.id,
    #         after_message: false
    #     }

    #     expect(response).to be_successful
    #     expect(json['messages'].size).to eq(2)
    #   end
    # end


    # it "returns all the messages from the room if only the message_id is given" do
    #   person = create(:admin_user)
    #   ActsAsTenant.with_tenant(person.product) do
    #     login_as(person)
    #     room = create(:room, status: :active, public: true)
    #     msg1 = create(:message, room_id: room.id)
    #     msg2 = create(:message, room_id: room.id, created_at: DateTime.now + 2)

    #     get :index,
    #       params: {
    #         room_id: room.id,
    #         message_id: msg2.id
    #     }

    #     expect(response).to be_successful
    #     expect(json['messages'].size).to eq(2)
    #   end
    # end

    # it "returns all the messages from the room if chronologically params has bad value" do
    #   person = create(:admin_user)
    #   ActsAsTenant.with_tenant(person.product) do
    #     login_as(person)
    #     room = create(:room, status: :active, public: true)
    #     msg1 = create(:message, room_id: room.id)
    #     msg2 = create(:message, room_id: room.id, created_at: DateTime.now + 2)

    #     get :index,
    #       params: {
    #         room_id: room.id,
    #         message_id: msg2.id,
    #         chronologically: 'wrong'
    #     }

    #     expect(response).to be_successful
    #     expect(json['messages'].size).to eq(2)
    #   end
    # end
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

    it 'returns the post with reactions and tags' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post = create(:post, person: person)
        tag = Faker::Lorem.word
        post.tag_list = tag
        post.save
        post_reaction = create(:post_reaction, person: person, post: post)

        get :show, params: { id: post.id }
        expect(response).to be_successful

        pr = json["post"]["post_reaction"]
        expect(json["post"]["tags"]).to include(tag)
        expect(pr["id"]).to eq(post_reaction.id)
        expect(pr["post_id"]).to eq(post_reaction.post_id)
        expect(pr["person_id"]).to eq(post_reaction.person_id)
        expect(pr["reaction"]).to eq(post_reaction.reaction)
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

        patch :update, params: { id: post.id, post: { recommended: true }  }

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
  end

  # TODO: auto-generated
  describe "GET stats" do
    pending
  end
end
