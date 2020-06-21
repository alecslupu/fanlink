# frozen_string_literal: true

RSpec.describe Post, type: :model do
  before(:each) do
    @product = Product.first || create(:product)
    ActsAsTenant.current_tenant = @product
    @person = create(:person)
    @followed1 = create(:person)
    @followed2 = create(:person)
    @person.follow(@followed1)
    @person.follow(@followed2)
    @start_date = Date.parse("2018/1/1")
    @end_date = Date.parse("2018/1/3")
    created_in_range = @start_date + 1.day
    @followed1_post1 = create(:post, created_at: created_in_range - 1.minute, person: @followed1)
    @followed1_post2 = create(:post, created_at: created_in_range, person: @followed1)
    @followed2_post1 = create(:post, created_at: created_in_range + 1.minute, person: @followed2)
    @before_range = create(:post, created_at: @start_date - 1.day, person: @followed1) # before range
    create(:post, created_at: @end_date + 1.day) # after range
  end

  context "Valid" do
    it "should create a valid post" do
      expect(build(:post)).to be_valid
    end
  end

  describe "scopes" do
    describe ".id_filter" do
      it do
        expect(Post).to respond_to(:id_filter)
      end
      pending
    end
    describe ".person_id_filter" do
      it do
        expect(Post).to respond_to(:person_id_filter)
      end
      pending
    end

    describe ".person_filter" do
      it do
        expect(Post).to respond_to(:person_filter)
      end
      pending
    end

    describe ".body_filter" do
      it do
        expect(Post).to respond_to(:body_filter)
      end
      pending
    end
    describe ".posted_after_filter" do
      it do
        expect(Post).to respond_to(:posted_after_filter)
      end
      pending
    end
    describe ".posted_before_filter" do
      it do
        expect(Post).to respond_to(:posted_before_filter)
      end
      pending
    end
    describe ".status_filter" do
      it do
        expect(Post).to respond_to(:status_filter)
      end
      pending
    end
  end

  # we don't care about post status here because that should be handled with scope chaining
  # TODO: we should care about poster status WHEN we implement that
  describe ".following" do
    it "should get posts for someone you are following with your own" do
      expect(Post.following_and_own(@person).map { |p| p.id }.sort).to eq([@followed2_post1.id, @followed1_post2.id, @followed1_post1.id, @before_range.id].sort)
    end
  end

  # we don't care about post status here because that should be handled with scope chaining
  # TODO: we should care about poster status WHEN we implement that
  describe ".in_date_range" do
    it "should get posts in a date range" do
      expect(Post.in_date_range(@start_date, @end_date).map { |p| p.id }.sort).to eq([@followed2_post1.id, @followed1_post2.id, @followed1_post1.id].sort)
    end
  end
  describe "#body" do
    it "should let you create a disembodied nil post" do
      post = build(:post, body: nil)
      expect(post).to be_valid
    end
  end

  describe "#priority" do
    let(:person) { create(:person, product: @product) }
    let!(:post1) { create(:post, person: person, priority: 1) }
    let!(:post2) { create(:post, person: person, priority: 2) }
    let!(:post_other) { create(:post, priority: 1) }
    it "should not adjust priorities if priority is 0" do
      pre = post1.priority
      create(:post, person: person)
      expect(post1.reload.priority).to eq(pre)
    end
    it "should adjust priorities if priority is greater than 0 and there is post of equal priority" do
      create(:post, person: person, priority: 1)
      expect(post1.reload.priority).to eq(2)
      expect(post2.reload.priority).to eq(3)
      expect(post_other.priority).to eq(1)
    end
    it "should not adjust priorities if priority is greater than 0 but there is no post of equal priority" do
      _person = create(:person, product: @product)
      _post1 = create(:post, person: person, priority: 2)
      create(:post, person: _person, priority: 1)
      expect(_post1.reload.priority).to eq(2)
    end
  end

  describe "#product" do
    it "should return the product of the person" do
      expect(@followed1_post1.product).to eq(@product)
    end
  end

  describe "#reaction_breakdown" do
    it "should return the reaction counts in a hash" do
      reaction1, reaction2, reaction3 = "1F600", "1F601", "1F602"
      create(:post_reaction, post: @followed1_post1, reaction: reaction1)
      create(:post_reaction, post: @followed1_post1, reaction: reaction1)
      create(:post_reaction, post: @followed1_post1, reaction: reaction2)
      counts = @followed1_post1.reaction_breakdown
      expect(counts[reaction1]).to eq(2)
      expect(counts[reaction2]).to eq(1)
      expect(counts[reaction3]).to be_nil
    end
  end

  describe "#starts_at" do
    it "should not let you create a post that starts after it ends" do
      post = build(:post, starts_at: Time.zone.now + 1.day, ends_at: Time.zone.now + 23.hours)
      expect(post).not_to be_valid
      expect(post.errors[:starts_at]).not_to be_empty
    end
  end

  # TODO: auto-generated
  describe "#cache_key" do
    it "works" do
      post = build(:post)
      result = post.cache_key
      expect(result).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe "#comments" do
    it "works" do
      post = Post.new
      result = post.comments
      expect(result).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe "#product" do
    it "works" do
      post = build(:post)
      result = post.product
      expect(result).not_to be_nil
    end
    pending
  end

  # # TODO: auto-generated
  # describe "#cached_person" do
  #   it "works" do
  #     post = build(:post)
  #     result = post.cached_person
  #     expect(result).not_to be_nil
  #   end
  #   pending
  # end
  #

  # TODO: auto-generated
  describe "#cached_for_product" do
    it "works" do
      post = create(:post)
      product = post.product
      result = Post.cached_for_product(product)
      expect(result).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe "#process_et_response" do
    pending
  end

  # TODO: auto-generated
  describe "#video_thumbnail" do
    pending
  end

  # TODO: auto-generated
  describe "#flush_cache" do
    pending
  end

  # TODO: auto-generated
  describe "#reaction_breakdown" do
    pending
  end

  # TODO: auto-generated
  describe "#cached_reaction_count" do
    pending
  end

  # TODO: auto-generated
  describe "#cached_tags" do
    pending
  end

  # TODO: auto-generated
  describe "#reactions" do
    it "works" do
      post = create(:post)
      result = post.reactions
      expect(result).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe "#reported?" do
    it "works" do
      post = Post.new
      result = post.reported?
      expect(result).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe "#visible?" do
    pending
  end

  # TODO: auto-generated
  describe "#start_listener" do
    pending
  end

  # TODO: auto-generated
  describe "#published?" do
    it "works" do
      post = Post.new
      result = post.published?
      expect(result).not_to be_nil
    end
    pending
  end


  describe "#delete_real_time" do
    it "responds to method " do
      expect(Post.new).to respond_to(:delete_real_time)
    end
    pending
  end
  describe "#post" do
    it "responds to method " do
      expect(Post.new).to respond_to(:post)
    end
    pending
  end

end
