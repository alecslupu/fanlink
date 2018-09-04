class Api::V3::SessionDoc < Api::V3::BaseDoc
  doc_tag name: "Session", desc: "User session management."
  route_base "api/v3/session"

  components do
    resp SessionObject: ["HTTP/1.1 200 Ok", :json, data: {
      person: :PersonJson
    }]
  end

  api :index, "Check a session.", skip: [:SessionCookie] do
    desc "This is used to see if your current session is valid. We return the currently logged-in person if the session is still good and a 404 otherwise."
    response_ref 200 => :SessionObject
  end

  api :create, "Log someone in.", skip: [:SessionCookie] do
    desc "This is used to log someone in."
    form! data: {
      product!: { type: String, desc: "Internal name of product logging into." },
      email_or_username!: { type: String, desc: "The person's email address or username. Required unless using Facebook ID." },
      facebook_auth_token!: { type: String, desc: "The facebook auth token. Required unless using username/password." },
      password!: { type: String, format: "password", desc: "The person's password. Required unless using facebook_auth_token." },
      keep: { type: Boolean, desc: "NOT YET SUPPORTED. True if you want to keep them signed in, otherwise this will be a non-persistent session." }
    }
    response_ref 200 => :SessionObject
  end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :show, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :update, '' do
  #   desc ''
  #   form! data: {
  #     :! => {

  #     }
  #   }
  #   response_ref 200 => :
  # end

  api :destroy, "Log someone out.", skip: [:SessionCookie] do
    desc "This is used to log someone out."
    response_ref 200 => :OK
  end
end
