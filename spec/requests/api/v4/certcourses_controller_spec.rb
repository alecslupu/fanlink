require "swagger_helper"

RSpec.describe "Api::V4::CertcoursesController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/certcourses/{id}" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      let(:person_certcourse) { create(:person_certcourse) }
      let(:id) { person_certcourse.certcourse.id }

      tags "Courseware"
      parameter name: :id, in: :path, type: :string, required: false

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person_certcourse.person.id)}" }

        let!(:image_page) {
          ActsAsTenant.with_tenant(person_certcourse.person.product) {
            create(:image_page, certcourse_page: create(:certcourse_page, certcourse: person_certcourse.certcourse ) )
          }
        }
        let!(:video_page) {
          ActsAsTenant.with_tenant(person_certcourse.person.product) {
            create(:video_page, certcourse_page: create(:certcourse_page, certcourse: person_certcourse.certcourse ) )
          }
        }
        let!(:download_file_page) {
          ActsAsTenant.with_tenant(person_certcourse.person.product) {
            create(:download_file_page, certcourse_page: create(:certcourse_page, certcourse: person_certcourse.certcourse ) )
          }
        }

        # schema "$ref": "#/definitions/faulty"
        run_test! do |response|
          data = JSON.parse(response.body)
          raise data.inspect
        end
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person_certcourse.person.id)}" }
        let(:id) { Time.zone.now.to_i }

        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
=begin
        "CertcourseObject": {
          type: :object,
          "properties": {
            "certcourse_pages": {
                type: :array,
items: { "$ref": "#/definitions/FollowingJson" }

            }
          }
        },


{"certcourse_pages"=>[
  {
    "id"=>1,
    "course_id"=>4,
    "order"=>1,
    "content_type"=>"image",
    "timer"=>1,
    "media_content_type"=>"image/jpeg",
    "media_url"=>"/home/alecslupu/Sites/fanlink/backend/test_uploads/image_pages/1/images/large.jpg.jpg?1580753781",
    "media_url_large"=>"/home/alecslupu/Sites/fanlink/backend/test_uploads/image_pages/1/images/large.jpg.jpg?1580753781",
    "background_color_hex"=>"#744ed7",
    "is_passed"=>false
  },
  {
    "id"=>2,
"course_id"=>4,
"order"=>2,
"content_type"=>"video",
"timer"=>6,
"media_content_type"=>"video/mp4",
"media_url"=>"/home/alecslupu/Sites/fanlink/backend/test_uploads/video_pages/1/videos/short_video.mp4.mp4?1580753783",
"media_url_large"=>"", "background_color_hex"=>"#e2781c",
"is_passed"=>false
}, {
"id"=>3,
"course_id"=>4,
"order"=>3,
"content_type"=>"download_file",
"timer"=>1,
"media_content_type"=>"application/pdf",
"media_url"=>"/home/alecslupu/Sites/fanlink/backend/test_uploads/download_file_pages/1/documents/blank_test.pdf.pdf?1580753783",
"media_url_large"=>"",
"background_color_hex"=>"#3f2666",
"is_passed"=>false,
"caption"=>"[\"tempora\", \"ipsum\", \"assumenda\"]"}]}

=end
