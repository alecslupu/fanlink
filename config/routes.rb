# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get '/config/:internal_name' => 'config#index'
  get '/config/:internal_name/:id' => 'config#show'

  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :v1
  draw :v2
  draw :v3
  draw :v4

  post '/aws/video_transcoded' => 'aws#video_transcoded'

  get '/status' => 'application#status'
  # temporary hack to get around need for Accept header with api stuff
  # TODO: move the password reset controller update out of the api
  post '/people/password_reset' => 'api/v1/password_resets#update'
  namespace :admin do
    post 'login' => 'sessions#create'
    get 'logout' => 'sessions#destroy'
    get ':product_internal_name' => 'sessions#login_redirect'

    get ':product_internal_name/login' => 'sessions#new', as: :login_screen
    root to: redirect('/admin_portal')
  end
  get ':product/share_post/:post_id', to: 'posts#share', as: 'cache_post'


  mount Sidekiq::Web, at: '/sidekiq'

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  mount RailsAdmin::Engine => '/admin_portal', as: 'rails_admin'

  mount Fanlink::Static::Engine, at: '/static'
  root to: redirect('https://fan.link')
end
