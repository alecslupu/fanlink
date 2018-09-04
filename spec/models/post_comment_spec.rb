RSpec.describe PostComment, type: :model do
  before(:all) do
    @product = Product.first || create(:product)
    ActsAsTenant.current_tenant = @product
    @person = create(:person)
    @followed1 = create(:person)
    @followed2 = create(:person)
    @person.follow(@followed1)
    @person.follow(@followed2)
    @followed1_post1 = create(:post, person: @followed1)
    @followed1_post2 = create(:post, person: @followed1)
    @followed2_post1 = create(:post, person: @followed2)
  end

  describe "#person" do
    it "should not let you create a post comment without a person" do
      cmt = @followed1_post1.post_comments.create(body: "this is not going to work")
      expect(cmt).not_to be_valid
    end
  end
  describe "#body" do
    it "should not let you create a post comment without a body" do
      cmt = @followed1_post1.post_comments.create(person_id: @person.id)
      expect(cmt).not_to be_valid
    end
  end
  describe "#post" do
    it "should not let you create a post comment without a post" do
      cmt = PostComment.create(body: "this will not work", person_id: @person.id)
      expect(cmt).not_to be_valid
    end
  end
end
