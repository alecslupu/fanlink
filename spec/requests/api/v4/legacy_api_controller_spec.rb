require "swagger_helper"

RSpec.describe "Api::V4::SessionController", type: :request, swagger_doc: "v4/swagger.json" do
  #send_email_courseware_client_person_certificate POST     /courseware/client/people/:person_id/certificates/:id/send_email(.:format)                  api/v4/courseware/client/certificates#send_email {:format=>:json}
  #download_courseware_client_person_certificate GET      /courseware/client/people/:person_id/certificates/:id/download(.:format)                    api/v4/courseware/client/certificates#download {:format=>:json}
  #courseware_client_person_certificate_certcourses GET      /courseware/client/people/:person_id/certificates/:certificate_id/certcourses(.:format)     api/v4/courseware/client/certcourses#index {:format=>:json}
  #courseware_client_person_certificate_certcourse GET      /courseware/client/people/:person_id/certificates/:certificate_id/certcourses/:id(.:format) api/v4/courseware/client/certcourses#show {:format=>:json}
  #courseware_client_person_certificates GET      /courseware/client/people/:person_id/certificates(.:format)                                 api/v4/courseware/client/certificates#index {:format=>:json}
  #courseware_client_person_certificate GET      /courseware/client/people/:person_id/certificates/:id(.:format)                             api/v4/courseware/client/certificates#show {:format=>:json}
  #courseware_client_people GET      /courseware/client/people(.:format)                                                         api/v4/courseware/client/people#index {:format=>:json}

  path "/courseware/client/people/{person_id}/certificates/{id}/send_email" do
    post "" do

    end
  end
  path "/courseware/client/people/{person_id}/certificates/{id}/download" do
    get "" do

    end
  end
  path "/courseware/client/people/{person_id}/certificates/{certificate_id}/certcourses" do
    get "" do

    end
  end
  path "/courseware/client/people/{person_id}/certificates/{certificate_id}/certcourses/{id}" do
    get "" do

    end
  end
  path "/courseware/client/people/{person_id}/certificates" do
    get "" do

    end
  end
  path "/courseware/client/people/{person_id}/certificates/{id}" do
    get "" do

    end
  end
  path "/courseware/client/people" do
    get "" do

    end
  end
  path "/quests" do
     get "" do
    #    tags ["quests", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
    #    response "200", "HTTP/1.1 200 Ok" do
    #      run_test!
    #    end
    #    response "401", "" do
    #      run_test!
    #    end
    #    response "404", "" do
    #      run_test!
    #    end
     end
  end
  path "/quests/{id}" do
     get "" do
    #    tags ["quests", 'android-old']
    #
    #    produces "application/vnd.api.v4+json"
    #    response "200", "HTTP/1.1 200 Ok" do
    #      run_test!
    #    end
    #    response "401", "" do
    #      run_test!
    #    end
    #    response "404", "" do
    #      run_test!
    #    end
     end
  end
  path "/blocks" do
    post "" do
  #    tags ["relation", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
    end
  end
  path "/steps/{stepId}/completions" do
   post "" do
  #    tags ["steps", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
  end
  path "/events" do
   get "" do
  #    tags ["events", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
  end
  path "/events/{id}/checkins" do
   delete "" do
  #    tags ["events", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
   post "" do
  #    tags ["events", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
   get "" do
  #    tags ["events", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #
   end
  end
  #
  ## kotlin stuff
  path "config/{app}.json" do
   get "" do
  #    tags ["config", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
  end
  path "/people/person/{username}" do
   get "" do
  #    tags ["user", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #      response "200", "HTTP/1.1 200 Ok" do
  #        run_test!
  #      end
  #      response "401", "" do
  #        run_test!
  #      end
  #      response "404", "" do
  #        run_test!
  #      end
   end
  end
  path "/people/recommended" do
   get "" do
  #    tags ["user", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    context  "product_account_filter" do
  #      response "200", "HTTP/1.1 200 Ok" do
  #        run_test!
  #      end
  #      response "401", "" do
  #        run_test!
  #      end
  #      response "404", "" do
  #        run_test!
  #      end
  #    end
   end
  end
  path "/certificates" do
   get "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
  end
  path "/certificates/{certificateId}" do
   get "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
  end
  path "/certificates/{certificateId}/certcourses" do
   get "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
  end
  path "/person_certificates" do
   post "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    context "set certificate name " do
  #
  #      response "200", "HTTP/1.1 200 Ok" do
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
  #      response "200", "HTTP/1.1 200 Ok" do
  #        run_test!
  #      end
  #      response "401", "" do
  #        run_test!
  #      end
  #      response "404", "" do
  #        run_test!
  #      end
  #    end
   end
  end
  path "/people/send_certificate" do
   post "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
  end
  path "/person_certcourses" do
   post "" do
  #    tags ["education", 'kotlin']
  #
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    response "200", "HTTP/1.1 200 Ok" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
   end
  end
end
