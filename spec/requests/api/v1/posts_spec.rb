describe "Posts (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @followee1 = create(:person, product: @person.product)
    @followee2 = create(:person, product: @person.product)
    @nonfollowee = create(:person, product: @person.product)
    @person.follow(@followee1)
    @person.follow(@followee2)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new post" do
      expect_any_instance_of(Api::V1::PostsController).to receive(:post_post).and_return(true)
      login_as(@person)
      body = "Do you like my body?"
      post "/posts", params: { post: { body: body } }
      expect(response).to be_success
      post = Post.last
      expect(post.person).to eq(@person)
      expect(post.body).to eq(body)
      expect(json["post"]).to eq(post_json(post))
    end
    it "should not create a new post if not logged in" do
      expect_any_instance_of(Api::V1::MessagesController).not_to receive(:post_post)
      post "/posts", params: { message: { body: "not gonna see my body" } }
      expect(response).to be_unauthorized
    end
  end

  describe "#destroy" do
    it "should delete message from original creator" do
      expect_any_instance_of(Api::V1::PostsController).to receive(:delete_post).and_return(true)
      login_as(@person)
      post = create(:post, person: @person, status: :published)
      delete "/posts/#{post.id}"
      expect(response).to be_success
      expect(post.reload.deleted?).to be_truthy
    end
    it "should not delete post from someone else" do
      expect_any_instance_of(Api::V1::PostsController).to_not receive(:delete_message)
      p = create(:person)
      login_as(@person)
      post = create(:post, person: p, status: :published)
      delete "/posts/#{post.id}"
      expect(response).to be_not_found
      expect(post.reload.published?).to be_truthy
    end
    it "should not delete message if not logged in" do
      expect_any_instance_of(Api::V1::PostsController).to_not receive(:delete_post)
      post = create(:post, person: @person, status: :published)
      delete "/posts/#{post.id}"
      expect(response).to be_unauthorized
    end
  end

  # with messages we stubbed the scope and tested that separately, here we are essentially testing the scopes
  # and controller action together for no particular reason
  describe "#index" do
    created_in_range = Date.parse("2018-01-02").end_of_day
    let!(:post11) { create(:post, person: @followee1, status: :published, created_at: created_in_range - 1.hour) }
    let!(:post12) { create(:post, person: @followee1, status: :published, created_at: created_in_range - 30.minutes)  }
    let!(:post21) { create(:post, person: @followee2, status: :published, created_at: created_in_range) }
    let!(:post22) { create(:post, person: @followee2, status: :published, created_at: created_in_range + 30.minutes) }
    let!(:postnofollow) { create(:post, person: @nonfollowee, status: :published, created_at: created_in_range)}
    let!(:postrejected) { create(:post, person: @followee1, status: :rejected, created_at: created_in_range)}
    let!(:postexpired) { create(:post, person: @followee2, status: :published, ends_at: Time.zone.now - 1.hour, created_at: created_in_range) }
    let!(:postpredates) { create(:post, person: @followee1, status: :published, created_at: Date.parse("2017-12-31")) }
    let!(:postpremature) { create(:post, person: @followee2, status: :published, starts_at: Time.now + 1.hour, created_at: created_in_range) }
    let(:from) { "2018-01-01" }
    let(:to) { "2018-01-03" }
    it "should get a list of posts for a date range without limit" do
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: to }
      expect(response).to be_success
      expect(json["posts"].map { |p| p["id"] }).to eq([post22.id.to_s, post21.id.to_s, post12.id.to_s, post11.id.to_s])
    end
    it "should get a list of posts for a date range with limit" do
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: to, limit: 2 }
      expect(response).to be_success
      expect(json["posts"].map { |p| p["id"] }).to eq([post22.id.to_s, post21.id.to_s])
    end
    it "should not get the list if not logged in" do
      get "/posts", params: { from_date: from, to_date: to, limit: 2 }
      expect(response).to be_unauthorized
    end
    it "should return unprocessable if invalid from date" do
      login_as(@person)
      get "/posts", params: { from_date: "what's this", to_date: to }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("invalid date")
    end
    it "should return unprocessable if invalid to date" do
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: "nonsense" }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("invalid date")
    end
    it "should return unprocessable if missing dates" do
      login_as(@person)
      get "/posts", params: { }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Missing")
    end
    it "should return unprocessable if missing from date" do
      login_as(@person)
      get "/posts", params: { to_date: to }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Missing")
    end
    it "should return unprocessable if missing to date" do
      login_as(@person)
      get "/posts", params: { from_date: from }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Missing")
    end
    # it "should return unprocessable if invalid to date" do
    #   login_as(@person)
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: "who me?", limit: 1 }
    #   expect(response).to be_unprocessable
    #   expect(json["errors"]).to include("invalid date")
    # end
    # it "should return unprocessable if missing from date" do
    #   login_as(@person)
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { to_date: to, limit: 1 }
    #   expect(response).to be_unprocessable
    #   expect(json["errors"]).to include("invalid date")
    # end
    # it "should return unprocessable if missing to date" do
    #   login_as(@person)
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, limit: 1 }
    #   expect(response).to be_unprocessable
    #   expect(json["errors"]).to include("invalid date")
    # end
    # it "should return 404 if room from another product" do
    #   login_as(@person)
    #   room_other = create(:room, product: create(:product))
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room_other.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #   expect(response).to be_not_found
    # end
    # it "should return not found if room inactive" do
    #   login_as(@person)
    #   room.inactive!
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #   expect(response).to be_not_found
    #   room.active!
    # end
    # it "should return not found if room deleted" do
    #   login_as(@person)
    #   room.deleted!
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #   expect(response).to be_not_found
    #   room.active!
    # end
    # it "should return unauthorized if not logged in" do
    #   expect(Message).to_not receive(:for_date_range)
    #   get "/rooms/#{room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #   expect(response).to be_unauthorized
    # end
    # describe "#private?" do
    #   it "should get messages if member of private room" do
    #     login_as(@person)
    #     msg = create(:message, room: @private_room, body: "wat wat")
    #     expect(Message).to receive(:for_date_range).with(@private_room, Date.parse(from), Date.parse(to), 1).and_return(Message.order(created_at: :desc).where(id: [msg.id]))
    #     expect_any_instance_of(Api::V1::MessagesController).to receive(:clear_message_counter).with(@private_room, @person).and_return(true)
    #     get "/rooms/#{@private_room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #     expect(response).to be_success
    #     expect(json["messages"].first).to eq(message_json(msg))
    #   end
    #   it "should return not found if not member of private room" do
    #     p = create(:person)
    #     login_as(p)
    #     get "/rooms/#{@private_room.id}/messages", params: { from_date: from, to_date: to, limit: 1 }
    #     expect(response).to be_not_found
    #   end
    # end
  end

  describe "#show" do
    it "should get a visible post" do
      post = create(:post, person: @person, status: :published)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post))
    end
    it "should not get a deleted post" do
      post = create(:post, person: @person, status: :deleted)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should not get a rejected post" do
      post = create(:post, person: @person, status: :rejected)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should get a post with a start date and no end date" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now - 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post))
    end
    it "should get an unexpired post with no start date and an end date" do
      post = create(:post, person: @person, status: :published, ends_at: Time.now + 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post))
    end
    it "should get an unexpired post with both dates" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now - 1.hour, ends_at: Time.now + 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post))
    end
    it "should not get a premature post with a start date and no end date" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now + 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should not get an expired post with no start date and an end date" do
      post = create(:post, person: @person, status: :published, ends_at: Time.now - 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should not get a premature post with both dates" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now + 1.hour, ends_at: Time.now + 2.hours)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should not get an expired post with both dates" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now - 3.hours, ends_at: Time.now - 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
  end
end