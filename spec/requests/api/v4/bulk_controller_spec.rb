require "swagger_helper"

RSpec.describe "Api::V4::SessionController", type: :request, swagger_doc: "v4/swagger.json" do
  # path "/rooms" do
  #  post "" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :room, in: :formData, type: :array
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  #
  #  get "Private rooms" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :private, in: :path, type: :boolean
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  # end
  #
  # path "/people" do
  #  get "" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :username_filter, in: :query, type: :string
  #    parameter name: :email_filer, in: :query, type: :string
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  # end
  #
  # path "people/{id}" do
  #  patch "Update person" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :id, in: :path, type: :integer
  #    parameter name: :email, in: :formData, type: :string
  #    parameter name: :biography, in: :formData, type: :string
  #    parameter name: :name, in: :formData, type: :string
  #    parameter name: :username, in: :formData, type: :string
  #    parameter name: :picture, in: :formData, type: :file
  #    parameter name: :gender, in: :formData, type: :string
  #    parameter name: :birthdate, in: :formData, type: :date
  #    parameter name: :city, in: :formData, type: :string
  #    parameter name: :country_code, in: :formData, type: :string
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  # end
  # path "people/{id}/change_password" do
  #  patch "" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :current_password, in: :formData, type: :string
  #    parameter name: :new_password, in: :formData, type: :string
  #    parameter name: :id, in: :path, type: :integer
  #
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  # end
  #
  # path "rooms/{room_id}/messages/{id}" do
  #  get "Private rooms" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :id, in: :path, type: :integer
  #    parameter name: :room_id, in: :path, type: :integer
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  # end
  # path "rooms/{id}/messages" do
  #  get "Private rooms" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :id, in: :path, type: :integer
  #    parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
  #    parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum"
  #    parameter name: :from_date, in: :query, type: :date, description: " Lorem ipsum"
  #    parameter name: :to_date, in: :query, type: :date, description: " Lorem ipsum"
  #    parameter name: :pinned, in: :formData, type: :string, enum: [:yes, :no], description: " Lorem ipsum"
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  # end
  #
  # path "/posts" do
  #  get "Private rooms" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
  #    parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum"
  #    parameter name: :categories, in: :query, type: :string, required: false, description: " Lorem ipsum"
  #    parameter name: :promoted, in: :query, type: :boolean, required: false, enum: [true, false], description: " Lorem ipsum"
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  # end
  # path "/posts/tags" do
  #  get "Private rooms" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
  #    parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum"
  #    parameter name: :tag_name, in: :query, type: :string, required: false, description: " Lorem ipsum"
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  # end
  # path "/posts/{id}" do
  #  get "Private rooms" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :id, in: :path, type: :integer
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  #  delete "Private rooms" do
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #
  #    parameter name: :id, in: :path, type: :integer
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  # end
  #
end

RSpec.describe "Api::V4::SessionController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/people" do
    get "" do
      tags ["users", 'android-old']
      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context  "email_filer" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context  "username_filter" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/people/{id}" do
    patch "" do
      tags ["users", 'android-old']

      produces "application/vnd.api.v4+json"
      context "first" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "sal" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/people/{id}/change_password" do
    patch "" do
      tags ["users", 'android-old']

      produces "application/vnd.api.v4+json"

      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/rooms" do
    get "" do
      tags ["chat", 'android-old']

      produces "application/vnd.api.v4+json"
      context "private" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "all" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/rooms/{room_id}/messages/{id}" do
    get "" do
      tags ["chat", 'android-old']
      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    delete "" do
      tags ["chat", 'android-old']
      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/rooms/{id}/messages" do
    get "" do
      tags ["chat", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "Date range" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "all" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "pinned" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end

    end
    post "" do
      tags ["chat", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/posts/tags" do
    get "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/posts/{id}" do
    get "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    delete "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/posts" do
    get "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      context "categories" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "promoted" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end

    end
    post "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/rooms/{room_id}/message_reports" do
    post "" do
      tags ["chat", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/post_comment_reports" do
    post "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    get "" do
      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/post_reports" do
    post "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/posts/{post_id}/comments/{id}" do
    delete "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/rooms/{room_id}/messages/{id}" do
    delete "" do
      tags ["chat", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/rooms/{id}" do
    patch "" do
      tags ["chat", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    delete "" do
      tags ["chat", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/relationships" do
    post "" do
      tags ["relation", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    get "" do
      tags ["relation", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "all" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "with_id" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end

  path "/relationships/{id}" do
    delete "" do
      tags ["relation", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    patch "" do
      tags ["relation", 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "denied" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "friended" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "withdrawn" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/blocks" do
    post "" do
      tags ["relation", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/posts/{id}/reactions" do
    delete "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    post "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/quests" do
    get "" do
      tags ["quests", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/quests/{id}" do
    get "" do
      tags ["quests", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/people/{id}" do
    get "" do
      tags ["quests", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    patch "" do
      tags ["quests", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/posts/{id}" do
    patch "" do
      tags ["post", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/steps/{stepId}/completions" do
    post "" do
      tags ["steps", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/message_reports" do
    get "" do
      tags ["steps", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/categories" do
    get "" do
      tags ["categories", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/events" do
    get "" do
      tags ["events", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/events/{id}/checkins" do
    delete "" do
      tags ["events", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    post "" do
      tags ["events", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    get "" do
      tags ["events", 'android-old']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end

    end
  end

  # kotlin stuff
  path "config/{app}.json" do
    get "" do
      tags ["config", 'kotlin']

      produces "application/vnd.api.v4+json"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/people" do
    post "" do
      tags ["user", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/people/password_forgot" do
    post "" do
      tags ["user", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/rooms/{id}/messages" do
    post "" do
      tags ["chat", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/rooms" do
    get "" do
      tags ["chat", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "all rooms" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "private rooms" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/badge_actions" do
    post "" do
      tags ["badge", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
    end
  end
  path "/levels" do
    get "" do
      tags ["badge", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
    end
  end
  path "/badges" do
    get "" do
      tags ["badge", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
    end
  end
  path "/people{id}" do
    get "" do
      tags ["user", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
    end
  end
  path "/people/person/{username}" do
    get "" do
      tags ["user", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
    end
  end
  path "/people/recommended" do
    get "" do
      tags ["user", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context  "product_account_filter" do
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/people" do
    get "" do
      tags ["user", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context  "product_account_filter" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/relationships/{id}" do
    patch "" do
      tags ["relations", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "denied" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "friended" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "withdrawn" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/relationships" do
    post "" do
      tags ["relations", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    get "" do
      tags ["relations", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "all" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "with_id" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/posts/{id}/polls/{poll_id}/poll_options/{poll_option_id}/cast_vote" do
    post "" do
      tags ["post", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/post_reports" do
    post "" do
      tags ["post", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/posts" do
    get "" do
      tags ["post", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/posts/recommended" do
    get "" do
      tags ["post", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/posts/{id}/comments" do
    get "" do
      tags ["post", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    post "" do
      tags ["post", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/certificates" do
    get "" do
      tags ["education", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/certificates/{certificateId}" do
    get "" do
      tags ["education", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/certificates/{certificateId}/certcourses" do
    get "" do
      tags ["education", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/person_certificates" do
    post "" do
      tags ["education", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "set certificate name " do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "purchase certificate" do

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
  path "/people/send_certificate" do

    post "" do
      tags ["education", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/certcourses/{id}" do
    get "" do
      tags ["education", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/person_certcourses" do
    post "" do
      tags ["education", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/person_certcourses/send_email" do
    post "" do
      tags ["education", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/interests/{id}/add" do
    post "" do
      tags ["interests", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/interests/{id}/remove" do
    post "" do
      tags ["interests", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/interests" do
    get "" do
      tags ["interests", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/people/{user_id}/interests" do
    get "" do
      tags ["interests", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/interests/match" do
    get "" do
      tags ["interests", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
  end
  path "/followings" do
    post "" do
      tags ["relations", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
    end
    get "" do
      tags ["relations", 'kotlin']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "" do
        # followed_id
        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
      context "" do
        # follower_id

        response "200", "" do
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          run_test!
        end
      end
    end
  end
end
