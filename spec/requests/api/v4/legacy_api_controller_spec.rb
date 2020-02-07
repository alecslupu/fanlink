require "swagger_helper"

RSpec.describe "Api::V4::SessionController", type: :request, swagger_doc: "v4/swagger.json" do
  #send_email_courseware_client_person_certificate POST     /courseware/client/people/:person_id/certificates/:id/send_email(.:format)                  api/v4/courseware/client/certificates#send_email {:format=>:json}
  #download_courseware_client_person_certificate GET      /courseware/client/people/:person_id/certificates/:id/download(.:format)                    api/v4/courseware/client/certificates#download {:format=>:json}
  #courseware_client_person_certificate_certcourses GET      /courseware/client/people/:person_id/certificates/:certificate_id/certcourses(.:format)     api/v4/courseware/client/certcourses#index {:format=>:json}
  #courseware_client_person_certificate_certcourse GET      /courseware/client/people/:person_id/certificates/:certificate_id/certcourses/:id(.:format) api/v4/courseware/client/certcourses#show {:format=>:json}
  #courseware_client_person_certificates GET      /courseware/client/people/:person_id/certificates(.:format)                                 api/v4/courseware/client/certificates#index {:format=>:json}
  #courseware_client_person_certificate GET      /courseware/client/people/:person_id/certificates/:id(.:format)                             api/v4/courseware/client/certificates#show {:format=>:json}


  path "/courseware/client/people/{person_id}/certificates/{id}/send_email" do
    post "" do
      security [Bearer: []]
      let(:Authorization) { "" }

      parameter name: :person_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      produces "application/vnd.api.v4+json"

      # tags "Courseware-tst"
      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
  path "/courseware/client/people/{person_id}/certificates/{id}/download" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      # tags "Courseware-tst"
      parameter name: :person_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
  path "/courseware/client/people/{person_id}/certificates/{certificate_id}/certcourses" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      # tags "Courseware-tst"
      parameter name: :person_id, in: :path, type: :string
      parameter name: :certificate_id, in: :path, type: :string

      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
  path "/courseware/client/people/{person_id}/certificates/{certificate_id}/certcourses/{id}" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      # tags "Courseware-tst"
      parameter name: :person_id, in: :path, type: :string
      parameter name: :certificate_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end

  path "/quests" do
     get "" do

       security [Bearer: []]
       let(:Authorization) { "" }
       produces "application/vnd.api.v4+json"
       response "200", "HTTP/1.1 200 Ok" do
         run_test!
       end
       response "401", "" do
         run_test!
       end
       response "404", "" do
         run_test!
       end
       response 500, "Internal server error" do
         document_response_without_test!
       end
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
       security [Bearer: []]
       let(:Authorization) { "" }
       parameter name: :id, in: :path, type: :string

       produces "application/vnd.api.v4+json"
       response "200", "HTTP/1.1 200 Ok" do
         run_test!
       end
       response "401", "" do
         run_test!
       end
       response "404", "" do
         run_test!
       end
       response 500, "Internal server error" do
         document_response_without_test!
       end
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

      security [Bearer: []]
      let(:Authorization) { "" }
      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
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
  path "/steps/{step_id}/completions" do
   post "" do
     security [Bearer: []]
     let(:Authorization) { "" }
     parameter name: :step_id, in: :path, type: :string

     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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

     security [Bearer: []]
     let(:Authorization) { "" }
     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
     security [Bearer: []]
     let(:Authorization) { "" }
     parameter name: :id, in: :path, type: :string

     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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

     security [Bearer: []]
     let(:Authorization) { "" }
     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
     security [Bearer: []]
     let(:Authorization) { "" }
     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
     security [Bearer: []]
     let(:Authorization) { "" }
     parameter name: :app, in: :path, type: :string

     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
     security [Bearer: []]
     let(:Authorization) { "" }
     parameter name: :username, in: :path, type: :string


     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
     security [Bearer: []]
     let(:Authorization) { "" }
     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
     security [Bearer: []]
     let(:Authorization) { "" }
     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
  path "/certificates/{certificate_id}" do
   get "" do
     security [Bearer: []]
     let(:Authorization) { "" }
     parameter name: :certificate_id, in: :path, type: :string

     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
  path "/certificates/{certificate_id}/certcourses" do
   get "" do
     security [Bearer: []]
     let(:Authorization) { "" }
     parameter name: :certificate_id, in: :path, type: :string

     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
     security [Bearer: []]
     let(:Authorization) { "" }
     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
     security [Bearer: []]
     let(:Authorization) { "" }
     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
     security [Bearer: []]
     let(:Authorization) { "" }
     produces "application/vnd.api.v4+json"
     response "200", "HTTP/1.1 200 Ok" do
       run_test!
     end
     response "401", "" do
       run_test!
     end
     response "404", "" do
       run_test!
     end
     response 500, "Internal server error" do
       document_response_without_test!
     end
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
