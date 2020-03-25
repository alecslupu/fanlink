describe Api::V3::CategoriesController do
  before(:all) do
    @product = create(:product, can_have_supers: true)
    @person = create(:person, product: @product)
    @admin = create(:person, role: :admin, product: @product)
    @super_admin = create(:person, role: :super_admin, product: @product)
  end

  before(:each) do
    logout
  end

  describe ".index" do
    context "returns categories" do

      it "should return categories for super_admin" do
        true
      end

      it "should return categories for admin" do
        true
      end

      it "should return categories for staff" do
        true
      end

      it "should return categories for normal user" do
        true
      end

      it "should return categories for product account" do
        true
      end

      it "should return paginated results" do
        true
      end

      it "should return posts for category" do
        true
      end
    end
  end

  describe ".create" do
    context "create a category" do
      it "should be valid" do
        true
      end

      it "should return 422 when invalid" do
        true
      end
    end
  end

  describe ".show" do
  end

  describe ".update" do
  end

  describe ".destroy" do
    context "destroys a category" do
      it "404 when non admin" do
        login_as(@person)
        category = create(:category)
        delete "/categories/#{category.id}"
        expect(response).to have_http_status 404
      end

      it "200 when admin and deleted set to true" do
        login_as(@admin)
        category = create(:category)
        delete "/categories/#{category.id}"
        expect(response).to have_http_status 200
        expect(category.reload.deleted).to be_truthy
      end

      it "should not destroy without force flag" do
        login_as(@super_admin)
        category = create(:category)
        delete "/categories/#{category.id}"
        expect(category).to exist_in_database
      end

      it "should destroy force flag" do
        login_as(@super_admin)
        category = create(:category)
        delete "/categories/#{category.id}?force=1"
        expect(response).to have_http_status 200
        expect(category).not_to exist_in_database
      end

      it "should remove category from post" do # https://totallyobsessed.atlassian.net/projects/FLAPI/issues/FLAPI-691
        login_as(@admin)
        category = create(:category)
        post = create(:post, category: category)
        delete "/categories/#{category.id}"
        expect(post.reload.category_id).to be nil
      end
    end
  end
  describe ".select" do
  end
end
