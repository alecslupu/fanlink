class Api::V3::PeopleDoc < Api::V3::BaseDoc
  doc_tag name: "People", desc: "Users"
  route_base "api/v3/people"

  components do
    resp PeopleArray: ["HTTP/1.1 200 Ok", :json, data: {
      people: [
        person: :PersonJson
      ]
    }]
    resp PersonObject: ["HTTP/1.1 200 Ok", :json, data: {
      person: :PersonJson
    }]
    resp PersonPrivateObject: ["HTTP/1.1 200 Ok", :json, data: {
      person: :PersonPrivateJson
    }]
    # TODO: Copy this form and remove biography field.
    body! :PersonCreateForm, :form, data: {
      product!: { type: String, desc: "Internal name of the product." },
      person!: {
        email!: { type: String, format: "email", desc: "Email address (required unless using FB auth token)." },
        facebook_auth_token!: { type: String, desc: "Auth token from Facebook" },
        name: { type: String, desc: "User's name." },
        username!: { type: String, desc: "Username. This needs to be unique within product scope." },
        password!: { type: String, format: "password", desc: 'User\s password.' },
        picture: { type: File, desc: "Profile picture, this should be `image/gif`, `image/png`, or `image/jpeg`." },
        gender: { type: String, desc: "Gender. Valid options: unspecified (default), male, female." },
        birthdate: { type: String, formate: "date", desc: 'Birth dateTo date in format "YYYY-MM-DD".' },
        biography: { type: String, desc: "A paragraph a user can submit about themselves." },
        city: { type: String, desc: "Person's supplied city." },
        country_code: { type: String, desc: "Alpha2 code (two letters) from ISO 3166 list." },
        recommended: { type: Boolean, desc: "Sets the post to recommended. Available only to admins and product accounts." }
      }
    }

    body! :PersonUpdateForm, :form, data: {
      product!: { type: String, desc: "Internal name of the product." },
      person!: {
        email: { type: String, format: "email", desc: "Email address (required unless using FB auth token)." },
        facebook_auth_token: { type: String, desc: "Auth token from Facebook" },
        name: { type: String, desc: "User's name." },
        username: { type: String, desc: "Username. This needs to be unique within product scope." },
        password: { type: String, format: "password", desc: 'User\s password.' },
        picture: { type: File, desc: "Profile picture, this should be `image/gif`, `image/png`, or `image/jpeg`." },
        gender: { type: String, desc: "Gender. Valid options: unspecified (default), male, female." },
        birthdate: { type: String, formate: "date", desc: 'Birth dateTo date in format "YYYY-MM-DD".' },
        biography: { type: String, desc: "A paragraph a user can submit about themselves." },
        city: { type: String, desc: "Person's supplied city." },
        country_code: { type: String, desc: "Alpha2 code (two letters) from ISO 3166 list." },
        recommended: { type: Boolean, desc: "Sets the post to recommended. Available only to admins and product accounts." }
      }
    }
  end

  api :index, "Get a list of people." do
    need_auth :SessionCookie
    desc "This is used to get a list of people."
    query :username_filter, String, desc: "A username or username fragment to filter on."
    query :email_filter, String, desc: "An email or email fragment to filter on."
    response_ref 200 => :PeopleArray
  end

  api :create, "Create person." do
    desc 'This is used to create a new person.\nIf the account creation is successful, they will be logged in and we will send an onboarding email (if we have an email address for them).'
    body_ref :PersonCreateForm
    response_ref 200 => :PersonObject
  end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :show, "Get a person." do
    need_auth :SessionCookie
    desc "This is used to get a person."
    path! :id, Integer, desc: "ID"
    response_ref 200 => :PersonObject
  end

  api :update, "Update person." do
    need_auth :SessionCookie
    desc "This is used to update a person. Anything not mentioned is left alone."
    path! :id, Integer, desc: "ID"
    body_ref :PersonUpdateForm
    response_ref 200 => :PersonObject
  end

  api :change_password, "Change your password." do
    desc "This is used to change the logged in user's password."
    path! :id, Integer, desc: "The person id."
    form! data: {
      person!: {
        current_password!: { type: String, desc: "Current password." },
        new_password: { type: String, desc: "New password." }
      }
    }
    response_ref 200 => :OK
  end

  # api :destroy, '' do
  #   desc ''
  #   response_ref 200 => :OK
  # end
end
