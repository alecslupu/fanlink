require "spec_helper"

RSpec.describe Api::V4::TagsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    it"returns posts with reactions info" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person2 = create(:person)
        tag = create(:tag)
        post = create(:published_post,  person: person2)
        post.tags << tag

        person.follow(person2)
        person2.follow(person)

        get :index, params: { tag_name: tag.name }
        expect(response).to be_successful
      end
    end
  end
end
