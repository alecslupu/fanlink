Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin_portal", as: "rails_admin"


  post "/graphql", to: "graphql#execute"


  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
  # draw :v1
  # draw :v2
  # draw :v3
  draw :jko

  draw :trivia unless Rails.env.production?

  post "/aws/video_transcoded" => "aws#video_transcoded"

  get "/status" => "application#status"
  # temporary hack to get around need for Accept header with api stuff
  # TODO: move the password reset controller update out of the api
  post "/people/password_reset" => "api/v1/password_resets#update"
  draw :administrate

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
    match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
  end
end
