RSpec.describe PostComment, type: :model do
  before(:each) do
    @product = Product.first || create(:product)
    ActsAsTenant.current_tenant = @product
    @person = create(:person)
    @followed1 = create(:person)
    @followed2 = create(:person)
    @person.follow(@followed1)
    @person.follow(@followed2)
    @followed1_post1 = create(:post, person: @followed1)
    # @followed1_post2 = create(:post, person: @followed1)
    # @followed2_post1 = create(:post, person: @followed2)
  end

  context "Scopes" do
    describe ".person_filter" do
      it "responds to" do
        expect(PostComment).to respond_to(:person_filter)
      end
    end
    describe ".body_filter" do
      it "responds to" do
        expect(PostComment).to respond_to(:body_filter)
      end
    end
  end

  context "Valid" do
    it "should create a valid post comment" do
      expect(build(:post_comment)).to be_valid
    end
  end

  describe "#person" do
    it "should not let you create a post comment without a person" do
      cmt = @followed1_post1.post_comments.build(body: "this is not going to work")
      expect(cmt).not_to be_valid
    end
  end
  describe "#body" do
    it "should not let you create a post comment without a body" do
      cmt = @followed1_post1.post_comments.build(person_id: @person.id)
      expect(cmt).not_to be_valid
    end
  end
  describe "#post" do
    it "should not let you create a post comment without a post" do
      cmt = PostComment.new(body: "this will not work", person_id: @person.id)
      expect(cmt).not_to be_valid
    end
  end
  # TODO: auto-generated
  describe "#mentions" do
    pending
  end

  # TODO: auto-generated
  describe "#mentions=" do
    pending
  end

  # TODO: auto-generated
  describe "#product" do
    pending
  end
end
