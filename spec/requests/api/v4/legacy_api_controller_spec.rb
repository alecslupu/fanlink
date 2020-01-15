require "swagger_helper"

RSpec.describe "Api::V4::SessionController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/posts" do
    #get "" do
    #  tags ["post", 'android-old']
    #
    #  produces "application/vnd.api.v4+json"
    #  context "categories" do
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
    #  tags ["post", 'kotlin']
    #
    #  produces "application/vnd.api.v4+json"
    #  consumes "multipart/form-data"
    #  response "200", "" do
    #    run_test!
    #  end
    #  response "401", "" do
    #    run_test!
    #  end
    #  response "404", "" do
    #    run_test!
    #  end
    #  context "promoted" do
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
    #end
    #post "" do
    #  tags ["post", 'android-old']
    #
    #  produces "application/vnd.api.v4+json"
    #  response "200", "" do
    #    run_test!
    #  end
    #  response "401", "" do
    #    run_test!
    #  end
    #  response "404", "" do
    #    run_test!
    #  end
    #end
  end

  path "/posts/{id}" do
    #  patch "" do
    #    tags ["post", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
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
    #  get "" do
    #    tags ["post", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
    #    response "200", "" do
    #      schema "$ref": "#/definitions/faulty"
    #      run_test!
    #    end
    #    response "401", "" do
    #      schema "$ref": "#/definitions/faulty"
    #      run_test!
    #    end
    #    response "404", "" do
    #      schema "$ref": "#/definitions/faulty"
    #      run_test!
    #    end
    #  end
    #  delete "" do
    #    tags ["post", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
    #    response "200", "" do
    #      schema "$ref": "#/definitions/faulty"
    #      run_test!
    #    end
    #    response "401", "" do
    #      schema "$ref": "#/definitions/faulty"
    #      run_test!
    #    end
    #    response "404", "" do
    #      run_test!
    #    end
    #  end
  end

  path "/posts/{post_id}/comments/{id}" do
    #  delete "" do
    #    tags ["post", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
    #    consumes "multipart/form-data"
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
  end

  path "/posts/{id}/comments" do
    #  get "" do
    #    tags ["post", 'kotlin']
    #
    #    produces "application/vnd.api.v4+json"
    #    consumes "multipart/form-data"
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
    #  post "" do
    #    tags ["post", 'kotlin']
    #
    #    produces "application/vnd.api.v4+json"
    #    consumes "multipart/form-data"
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
  end

  path "/posts/{id}/reactions" do
    #  delete "" do
    #    tags ["post", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
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
    #  post "" do
    #    tags ["post", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
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
  end

  path "/posts/{id}/polls/{poll_id}/poll_options/{poll_option_id}/cast_vote" do
    #  post "" do
    #    tags ["post", 'kotlin']
    #
    #    produces "application/vnd.api.v4+json"
    #    consumes "multipart/form-data"
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
  end

  path "/post_reports" do
    #  post "" do
    #    tags ["post", 'kotlin']
    #
    #    produces "application/vnd.api.v4+json"
    #    consumes "multipart/form-data"
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
  end

  path "/posts/tags" do
    #  get "" do
    #    tags ["post", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
    #    response "200", "" do
    #      schema "$ref": "#/definitions/faulty"
    #      run_test!
    #    end
    #    response "401", "" do
    #      schema "$ref": "#/definitions/faulty"
    #      run_test!
    #    end
    #    response "404", "" do
    #      schema "$ref": "#/definitions/faulty"
    #      run_test!
    #    end
    #  end
  end

  path "/posts/recommended" do
    #  get "" do
    #    tags ["post", 'kotlin']
    #
    #    produces "application/vnd.api.v4+json"
    #    consumes "multipart/form-data"
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
  end

  path "/post_comment_reports" do
    #  post "" do
    #    tags ["post", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
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
    #  get "" do
    #    produces "application/vnd.api.v4+json"
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
  end

  path "/message_reports" do
    #  get "" do
    #    tags ["steps", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
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
  end

  path "/quests" do
    #  get "" do
    #    tags ["quests", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
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
  end
  path "/quests/{id}" do
    #  get "" do
    #    tags ["quests", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
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
  end


  path "/blocks" do
  #  post "" do
  #    tags ["relation", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
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
  end
  path "/steps/{stepId}/completions" do
  #  post "" do
  #    tags ["steps", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
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
  end
  path "/events" do
  #  get "" do
  #    tags ["events", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
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
  end
  path "/events/{id}/checkins" do
  #  delete "" do
  #    tags ["events", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
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
  #  post "" do
  #    tags ["events", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
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
  #  get "" do
  #    tags ["events", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #
  #  end
  end
  #
  ## kotlin stuff
  path "config/{app}.json" do
  #  get "" do
  #    tags ["config", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
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
  end


  path "/people/person/{username}" do
  #  get "" do
  #    tags ["user", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #      response "200", "" do
  #        run_test!
  #      end
  #      response "401", "" do
  #        run_test!
  #      end
  #      response "404", "" do
  #        run_test!
  #      end
  #  end
  end
  path "/people/recommended" do
  #  get "" do
  #    tags ["user", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    context  "product_account_filter" do
  #      response "200", "" do
  #        run_test!
  #      end
  #      response "401", "" do
  #        run_test!
  #      end
  #      response "404", "" do
  #        run_test!
  #      end
  #    end
  #  end
  end
  path "/certificates" do
  #  get "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
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
  end
  path "/certificates/{certificateId}" do
  #  get "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
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
  end
  path "/certificates/{certificateId}/certcourses" do
  #  get "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
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
  end
  path "/person_certificates" do
  #  post "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    context "set certificate name " do
  #
  #      response "200", "" do
  #        run_test!
  #      end
  #      response "401", "" do
  #        run_test!
  #      end
  #      response "404", "" do
  #        run_test!
  #      end
  #    end
  #    context "purchase certificate" do
  #
  #      response "200", "" do
  #        run_test!
  #      end
  #      response "401", "" do
  #        run_test!
  #      end
  #      response "404", "" do
  #        run_test!
  #      end
  #    end
  #  end
  end
  path "/people/send_certificate" do
  #
  #  post "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
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
  end
  path "/certcourses/{id}" do
  #  get "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
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
  end
  path "/person_certcourses" do
  #  post "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
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
  end
  path "/person_certcourses/send_email" do
  #  post "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
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
  end

end
