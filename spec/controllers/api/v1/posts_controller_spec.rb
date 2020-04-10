require "spec_helper"


RSpec.describe Api::V1::PostsController, type: :controller do
  #
  #
  # before(:each) do
  #   logout
  # end

  describe "#create" do
    it "should create a new post and publish it" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = "Do you like my body?"
        post :create, params: {post: {body: body}}
        expect(response).to be_successful
        post = Post.last
        expect(post.person).to eq(person)
        expect(post.body).to eq(body)
        expect(post.published?).to be_truthy
        expect(post_json(json["post"])).to be true
      end
    end
    it "should create a new post and publish it with a lot of fields normal users really should not have access to but i am told they should" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = "Do you like my body?"
        startat = "2018-01-08T12:15:00Z"
        endat = "2018-06-08T12:15:59Z"
        prior = 123
        rpi = 1
        post :create, params: {post: {body: body, global: true, starts_at: startat, ends_at: endat, repost_interval: rpi, status: "rejected", priority: prior}}
        expect(response).to be_successful
        post = Post.last
        expect(post.global).to be_truthy
        expect(post.starts_at).to eq(Time.parse(startat))
        expect(post.ends_at).to eq(Time.parse(endat))
        expect(post.repost_interval).to eq(rpi)
        expect(post.status).to eq("rejected")
        expect(post.priority).to eq(prior)
      end
    end
    it "should allow admin to create recommended post" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        expect_any_instance_of(Post).to receive(:post)
        login_as(person)
        post :create, params: {post: {recommended: true}}
        expect(response).to be_successful
        post = Post.last
        expect(post.recommended).to be_truthy
      end
    end
    it "should not allow non admin to create recommended post" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post :create, params: {post: {recommended: true}}
        expect(response).to be_successful
        post = Post.last
        expect(post.recommended).to be_falsey
      end
    end
    it "should create a new post and publish it with a lot of fields normal users really should not have access to but i am told they should" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = "Do you like my body?"
        startat = "2018-01-08T12:15:00Z"
        endat = "2018-06-08T12:15:59Z"
        prior = 123
        rpi = 1
        post :create, params: {post: {body: body, global: true, starts_at: startat, ends_at: endat, repost_interval: rpi, status: "rejected", priority: prior}}
        expect(response).to be_successful
        post = Post.last
        expect(post.global).to be_truthy
        expect(post.starts_at).to eq(Time.parse(startat))
        expect(post.ends_at).to eq(Time.parse(endat))
        expect(post.repost_interval).to eq(rpi)
        expect(post.status).to eq("rejected")
        expect(post.priority).to eq(prior)
      end
    end
    it "should allow admin to create recommended post" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post :create, params: {post: {recommended: true}}
        expect(response).to be_successful
        post = Post.last
        expect(post.recommended).to be_truthy
      end
    end
    it "should not allow non admin to create recommended post" do
      person = create(:person)

      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post :create, params: {post: {recommended: true}}
        expect(response).to be_successful
        post = Post.last
        expect(post.recommended).to be_falsey
      end
    end
    it "should not create a new post if not logged in" do
      person = create(:person)

      ActsAsTenant.with_tenant(person.product) do
        post :create, params: {post: {body: "not gonna see my body"}}
        expect(response).to be_unauthorized
      end
    end

    it "creates a post with attachments when it's valid" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        post :create, params: {
          post: {
            body: "Body",
            picture: fixture_file_upload('images/better.png', 'image/png'),
            audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4')
          }
        }

        expect(response).to have_http_status(200)
        expect(Post.last.picture.exists?).to be_truthy
        expect(Post.last.audio.exists?).to be_truthy
        expect(json['post']['picture_url']).to include('better.png')
        expect(json['post']['audio_url']).to include('small_audio')
      end
    end
  end

  describe "#destroy" do
    it "should delete message from original creator" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post = create(:post, person: person, status: :published)
        delete :destroy, params: {id: post.id}
        expect(response).to be_successful
        expect(post.reload.deleted?).to be_truthy
      end
    end
    it "should not delete post from someone else" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        p = create(:person)
        post = create(:post, person: p, status: :published)
        delete :destroy, params: {id: post.id}
        expect(response).to be_not_found
        expect(post.reload.published?).to be_truthy
      end
    end
    it "should not delete post if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post = create(:post, person: person, status: :published)
        delete :destroy, params: {id: post.id}
        expect(response).to be_unauthorized
      end
    end
  end

  # with messages we stubbed the scope and tested that separately, here we are essentially testing the scopes
  # and controller action together for no particular reason
  describe "#index" do
    let(:created_in_range) { Date.parse("2018-01-02").end_of_day }
    let(:from) { "2018-01-01" }
    let(:to) { "2018-01-03" }
    it "should get a list of posts for a date range without limit" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        people = create_list(:person, 2)
        person.follow(people.first)
        person.follow(people.last)

        postloggedin = create(:published_post, person: person, created_at: created_in_range + 31.minutes)
        post11 = create(:published_post, person: people.first, status: :published, created_at: created_in_range - 1.hour)
        post12 = create(:published_post, person: people.first, status: :published, created_at: created_in_range - 30.minutes)
        post21 = create(:published_post, person: people.last, status: :published, created_at: created_in_range)
        post22 = create(:published_post, person: people.last, status: :published, created_at: created_in_range + 30.minutes)
        login_as(person)
        get :index, params: {from_date: from, to_date: to}
        expect(response).to be_successful
        expect(json["posts"].map { |p| p["id"] }).to eq([postloggedin.id.to_s, post22.id.to_s, post21.id.to_s, post12.id.to_s, post11.id.to_s])
      end
    end
    it "should get a list of posts for a date range with limit" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        people = create_list(:person, 2)
        postloggedin = create(:published_post, person: person, created_at: created_in_range + 31.minutes)
        post22 = create(:published_post, person: people.last, status: :published, created_at: created_in_range + 30.minutes)
        person.follow(people.last)

        login_as(person)
        get :index, params: {from_date: from, to_date: to, limit: 2}
        expect(response).to be_successful
        expect(json["posts"].map { |p| p["id"] }).to eq([postloggedin.id.to_s, post22.id.to_s])
      end
    end
    it "should not include posts from blocked person" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        blocked = create(:person)
        post = create(:published_post, person: blocked)
        person.block(blocked)
        login_as(person)
        get :index, params: {from_date: from, to_date: "2019-12-31"}
        expect(response).to be_successful
        expect(json["posts"].map { |p| p["id"] }).not_to include(post.id)
      end
    end
    it "should return correct language if device language provided" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        people = create_list(:person, 2)
        person.follow(people.first)
        person.follow(people.last)
        post11 = create(:published_post, person: people.first, status: :published, created_at: created_in_range - 1.hour)
        lan = "es"
        I18n.locale = lan

        request.headers.add "Accept-Language", lan + "-spa" # letters dont matter because we should be just using first two characters
        translation = "En espagnol"
        post11.set_translations({lan => {body: translation}})
        post11.save
        login_as(person)
        get :index, params: {from_date: from, to_date: to}
        expect(response).to be_successful
        post11_json = json["posts"].find { |p| p["id"] == post11.id.to_s }
        expect(post11_json["body"]).to eq(translation)
      end
    end
    it "should not get the list if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        get :index, params: {from_date: from, to_date: to, limit: 2}
        expect(response).to be_unauthorized
      end
    end
    it "should return unprocessable if invalid from date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: {from_date: "what's this", to_date: to}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Missing or invalid date(s)")
      end
    end
    it "should return unprocessable if invalid to date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: {from_date: from, to_date: "nonsense"}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Missing or invalid date(s)")
      end
    end
    it "should return unprocessable if missing dates" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: {}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Missing or invalid date(s)")
      end
    end
    it "should return unprocessable if missing from date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: {to_date: to}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Missing or invalid date(s)")
      end
    end
    it "should return unprocessable if missing to date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: {from_date: from}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Missing or invalid date(s)")
      end
    end
    it "should get a list of posts for a person" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        people = create_list(:person, 2)
        person.follow(people.first)
        post11 = create(:published_post, person: people.first, status: :published, created_at: created_in_range - 1.hour)
        post12 = create(:published_post, person: people.first, status: :published, created_at: created_in_range - 30.minutes)

        login_as(person)
        get :index, params: {from_date: from, to_date: to, person_id: people.first.id}
        expect(response).to be_successful
        expect(json["posts"].map { |p| p["id"] }).to eq([post12.id.to_s, post11.id.to_s])
      end
    end
    it "should return unprocessable for a badly formed person id" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: {from_date: from, to_date: to, person_id: "whodat"}
        expect(response).to be_unprocessable
        expect(json["errors"]).not_to be_empty
      end
    end
    it "should return unprocessable for a nonexistent person" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: {from_date: from, to_date: to, person_id: Person.last.id + 1}
        expect(response).to be_unprocessable
        expect(json["errors"]).not_to be_empty
      end
    end

    it 'returns all the messages with the attached image' do
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
          created_at: to,
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
        end
      end
    end
  end

  describe "#list" do
    it "should get the list of all posts unfiltered" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)
        get :list
        expect(response).to be_successful
        expect(json["posts"].count).to eq(10)
      end
    end
    it "should get list paginated at page 1" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)
        get :list, params: {page: 1, per_page: 2}
        expect(response).to be_successful
        expect(json["posts"].count).to eq(2)
        expect(post_list_json(json["posts"].first)).to be true
        expect(post_list_json(json["posts"].last)).to be true
      end
    end
    it "should get list paginated at page 2" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)
        get :list, params: {page: 2, per_page: 2}
        expect(response).to be_successful
        expect(json["posts"].count).to eq(2)
        expect(post_list_json(json["posts"].first)).to be true
        expect(post_list_json(json["posts"].last)).to be true
      end
    end
    it "should get the list of all posts filtered on person_id" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)

        person_id = Post.last.person_id
        get :list, params: {person_id_filter: person_id}
        posts = Post.where(person_id: person_id)
        expect(response).to be_successful
        expect(json["posts"].count).to eq(posts.count)
        expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
      end
    end

    it "should get the list of all posts filtered on full person username match" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)

        person = create(:person, created_at: 10.days.ago, username: "customusername")
        create(:post, person: person)


        get :list, params: {person_filter: person.username_canonical}
        posts = Post.where(person_id: person.id)
        expect(response).to be_successful
        expect(json["posts"].count).to eq(1)
        expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
      end
    end

    it "should get the list of all posts filtered on partial person username match" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)

        people_list = [create(:person, username: "user111", email: "user1112@example.com"),
                       create(:person, username: "user112", email: "user112@example.com"),
                       create(:person, username: "user121", email: "user121@example.com"),]
        people = [people_list.first, people_list[1]]
        10.times do |n|
          create(:post, person: people_list.sample, created_at: 10.days.ago + n.days)
        end

        get :list, params: {person_filter: "user11"}
        expect(response).to be_successful
        posts = Post.where(person_id: people)
        expect(json["posts"].count).to eq(posts.count)
        expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
      end
    end
    it "should get the list of all posts filtered on full person email match" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)

        people_list = [create(:person, username: "user111", email: "user1112@example.com"),
                       create(:person, username: "user112", email: "user112@example.com"),
                       create(:person, username: "user121", email: "user121@example.com"),]
        person = people_list.sample
        get :list, params: {person_filter: person.email}
        expect(response).to be_successful
        posts = Post.where(person_id: person.id)
        expect(json["posts"].count).to eq(posts.count)
        expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
      end
    end
    it "should get the list of all posts filtered on partial person email match" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)

        people_list = [create(:person, username: "user111", email: "user1112@example.com"),
                       create(:person, username: "user112", email: "user112@example.com"),
                       create(:person, username: "user121", email: "user121@example.com"),]
        people = [people_list.first, people_list[1]]
        get :list, params: {person_filter: "112@example"}
        expect(response).to be_successful
        posts = Post.where(person_id: people)
        expect(json["posts"].count).to eq(posts.count)
        expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
      end
    end
    it "should get the list of all posts filtered on full body match" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)
        post = create(:post, status: Post.statuses.keys.sample, created_at: 10.days.ago)
        post.save

        get :list, params: {body_filter: post.body}
        expect(response).to be_successful
        expect(json["posts"].count).to eq(1)
        expect(json["posts"].first["id"]).to eq(post.id.to_s)
      end
    end

    it "should get the list of all posts filtered on partial body match" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 9, created_at: 10.days.ago)
        post = create(:post, status: Post.statuses.keys.sample, created_at: 10.days.ago)
        post.body = "some body that I made up "
        post.save
        login_as(person)
        get :list, params: {body_filter: "some body"}
        expect(response).to be_successful
        expect(json["posts"].count).to eq(1)
      end
    end
    it "should get the list of all posts posted at or after some time matching all" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:post, 10, created_at: 10.days.ago)
        login_as(person)
        get :list, params: {posted_after_filter: 11.days.ago}
        expect(response).to have_http_status(200)
        expect(json["posts"].count).to eq(10)
      end
    end
    it "should get the list of all posts posted at or after some time matching some" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        10.times { |n| create(:post, created_at: (1 + n).days.ago) }

        get :list, params: {posted_after_filter: 7.days.ago.beginning_of_day.to_s}
        expect(response).to be_successful
        expect(json["posts"].count).to eq(7)
      end
    end

    it "should get the list of all posts posted at or before some time matching all" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        10.times { |n| create(:post, created_at: (1 + n).days.ago) }

        get :list, params: {posted_before_filter: 1.day.from_now.to_s}
        expect(response).to be_successful
        expect(json["posts"].count).to eq(10)
      end
    end
    it "should get the list of all posts posted on or after some time matching some" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        10.times { |n| create(:post, created_at: (1 + n).days.ago) }

        get :list, params: {posted_before_filter: 7.days.ago.beginning_of_day.to_s}
        expect(response).to be_successful
        expect(json["posts"].count).to eq(3)
      end
    end

    it "should get the list of all posts matching a status" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        10.times { |n| create(:published_post, created_at: (1 + n).days.ago) }

        published_posts = Post.published
        get :list, params: {status_filter: "published"}
        expect(response).to be_successful
        expect(json["posts"].count).to eq(published_posts.count)
      end
    end
    it "should get a list of posts filtered on body and posted_after" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        people_list = [create(:person, username: "user111", email: "user1112@example.com"),
                       create(:person, username: "user112", email: "user112@example.com"),
                       create(:person, username: "user121", email: "user121@example.com"),]
        10.times { |n| create(:published_post, person: people_list.sample, created_at: (1 + n).days.ago) }

        time_to_use = (10.days.ago + 4.days).beginning_of_day
        posts = Post.where(person: people_list.first).where("created_at >= ?", time_to_use)
        get :list, params: {person_id_filter: people_list.first.id, posted_after_filter: time_to_use.to_s}
        expect(response).to be_successful
        expect(json["posts"].count).to eq(posts.count)
      end
    end
    it "should give you a single post filtered on post id" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        post_list = create_list(:post, 10, created_at: 10.days.ago)

        post = post_list.first
        get :list, params: {id_filter: post.id}
        expect(response).to be_successful
        pjson = json["posts"]
        expect(pjson.count).to eq(1)
        expect(post_json(pjson.first)).to be true
      end
    end
    it "should not give you anything if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        get :index
        expect(response).to be_unauthorized
      end
    end
    it "should not give you anything if logged in as normal" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :list
        expect(response).to be_unauthorized
      end
    end
  end

  describe "#share" do
    it "should get a post without authentication" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)

        get :share, params: {id: flinkpost.id, product: flinkpost.product.internal_name}
        expect(response).to be_successful
        expect(post_share_json(json["post"])).to be true
      end
    end
    it "should 404 with valid post in different product" do
      person = create(:person)
      flinkpost = create(:published_post, person: create(:person, product: create(:product)))

      ActsAsTenant.with_tenant(person.product) do
        get :share, params: {id: flinkpost.id, product: person.product.internal_name}
        expect(response).to be_not_found
      end
    end
    it "should 404 with invalid post id" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        get :share, params: {product: person.product.internal_name, id: flinkpost.id + 1}
        expect(response).to be_not_found
      end
    end
    it "should 422 with invalid product" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)

        get :share, params: {product: "thiscannotpossiblyexist", id: flinkpost.id}
        expect(response).to be_unprocessable
      end
    end
    it "should get a post for different product than logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        get :share, params: {product: flinkpost.product.internal_name, id: flinkpost.id}
        expect(response).to be_successful
        expect(post_share_json(json["post"])).to be true
      end
    end
    it "should 404 on an unpublished post" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:post, person: person)
        Post.statuses.keys.each do |s|
          next if s == "published"
          flinkpost.update_column(:status, Post.statuses[s])
          get :share, params: {id: flinkpost.id, product: flinkpost.product.internal_name}
          expect(response).to be_not_found
        end
      end
    end
  end

  describe "#show" do
    it "should get a visible post" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(post_json(json["post"])).to be true
      end
    end
    it "should get a visible post with reaction counts" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        1.upto 4 do
          create(:post_reaction, post: flinkpost)
        end
        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(post_json(json["post"])).to be true
      end
    end
    it "should include current user reaction" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        reaction = create(:post_reaction, post: flinkpost, person: person)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(post_json(json["post"], nil, reaction)).to be true
        expect(json["post"]["post_reaction"]).not_to be_nil
      end
    end
    it "should return english language body if no device language provided and english exists" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        english = "This is English"
        flinkpost.set_translations( "en" => { body: english } )
        flinkpost.save
        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(json["post"]["body"]).to eq(english)
      end
    end
    it "should return original language body if no device language provided and no english exists" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        I18n.locale = "en"
        flinkpost = create(:published_post, person: person)
        flinkpost.body = "Something here"
        flinkpost.save
        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(json["post"]["body"]).to eq(flinkpost.body)
      end
    end
    it "should return correct language body if device language provided" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        lan = "es"
        I18n.locale = lan
        translation = "En espagnol"
        flinkpost.set_translations( lan => { body: translation  } )
        flinkpost.save
        request.headers.add "Accept-Language", (lan + "-spa")
        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(json["post"]["body"]).to eq(translation)
      end
    end
    it "should get a visible post with reaction counts" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        1.upto 4 do
          create(:post_reaction, post: flinkpost)
        end
        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(post_json(json["post"])).to be true
      end
    end
    it "should include current user reaction" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        reaction = create(:post_reaction, post: flinkpost, person: person)

        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(post_json(json["post"], nil, reaction)).to be true
        expect(json["post"]["post_reaction"]).not_to be_nil
      end
    end
    it "should not get a deleted post" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person, status: :deleted)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_not_found
      end
    end
    it "should not get a rejected post" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person, status: :rejected)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_not_found
      end
    end
    it "should get a post with a start date and no end date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person, starts_at: 1.hour.ago)
        get :show, params: {id: flinkpost.id}

        expect(response).to be_successful
        expect(post_json(json["post"])).to be true
      end
    end
    it "should get an unexpired post with no start date and an end date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person, ends_at: 1.hour.from_now)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(post_json(json["post"])).to be true
      end
    end
    it "should get an unexpired post with both dates" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person, starts_at: Time.now - 1.hour, ends_at: Time.now + 1.hour)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_successful
        expect(post_json(json["post"])).to be true
      end
    end
    it "should not get a premature post with a start date and no end date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person, starts_at: 1.hour.from_now)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_not_found
      end
    end
    it "should not get an expired post with no start date and an end date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person, ends_at: 1.hour.ago)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_not_found
      end
    end
    it "should not get a premature post with both dates" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person, starts_at: 1.hour.from_now, ends_at: 2.hours.from_now)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_not_found
      end
    end
    it "should not get an expired post with both dates" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person, starts_at: 3.hours.ago, ends_at: 1.hour.ago)
        get :show, params: {id: flinkpost.id}
        expect(response).to be_not_found
      end
    end
  end

  describe "#update" do
    let(:newbody) { "Do you like my new body?" }
    let(:global) { true }
    let(:starts_at) { "2018-03-12T18:55:30Z" }
    let(:ends_at) { "2018-03-13T18:55:30Z" }
    let(:repost_interval) { 5 }
    let(:status) { "published" }
    let(:priority) { 2 }
    it "should let admin update a post" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)

        patch :update, params: {id: flinkpost.id, post: {
          body: newbody, global: global, starts_at: starts_at,
          repost_interval: repost_interval, status: status,
          ends_at: ends_at, priority: priority, recommended: true,
        },}
        expect(response).to be_successful
        flinkpost.reload
        expect(flinkpost.body).to eq(newbody)
        expect(flinkpost.global).to eq(global)
        expect(flinkpost.starts_at).to eq(Time.parse(starts_at))
        expect(flinkpost.ends_at).to eq(Time.parse(ends_at))
        expect(flinkpost.repost_interval).to eq(repost_interval)
        expect(flinkpost.status).to eq(status)
        expect(flinkpost.priority).to eq(priority)
        expect(flinkpost.recommended).to be_truthy
      end
    end
    it "should not let not logged in update a post" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        flinkpost = create(:published_post, person: person)
        orig = flinkpost.body
        patch :update, params: {id: flinkpost.id,
                                post: {body: "notchanged", global: global, starts_at: starts_at, ends_at: ends_at,
                                       repost_interval: repost_interval, status: status, priority: priority,},}
        expect(response).to be_unauthorized
        expect(flinkpost.body).to eq(orig)
      end
    end
    it "should not let normal user update recommended" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)

        expect(flinkpost.recommended).to be_falsey
        patch :update, params: {id: flinkpost.id, post: {body: newbody, global: global, starts_at: starts_at, ends_at: ends_at,
                                                         recommended: true, repost_interval: repost_interval, status: status, priority: priority,},}
        expect(response).to be_successful
        flinkpost.reload
        expect(flinkpost.recommended).to be_falsey
      end
    end
    it "should let product account update recommended" do
      person = create(:person, product_account: true)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        flinkpost = create(:published_post, person: person)
        expect(flinkpost.recommended).to be_falsey
        patch :update, params: {id: flinkpost.id, post: {body: newbody, global: global, starts_at: starts_at, ends_at: ends_at,
                                                         recommended: true, repost_interval: repost_interval, status: status, priority: priority,},}
        expect(response).to be_successful
        flinkpost.reload
        expect(flinkpost.recommended).to be_truthy
      end
    end
  end
end
