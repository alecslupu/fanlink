namespace :admin do
  # api_version(:module => "Api::V1::Admin", :path => {:value => "v1"}, :header => {:name => "Accept", :value => "application/vnd.api.v1+json"}, :defaults => {:format => :json}) do

  # end

  # api_version(:module => "Api::V2::Admin", :path => {:value => "v2"}, :header => {:name => "Accept", :value => "application/vnd.api.v2+json"}, :defaults => {:format => :json}) do

  # end

  # api_version(:module => "Api::V3::Admin", :path => {:value => "v3"}, :header => {:name => "Accept", :value => "application/vnd.api.v3+json"}, :defaults => {:format => :json}) do

  # end

  resources :certificates
  resources :certcourses
  resources :certificate_certcourses
  resources :certcourse_pages
  resources :image_pages
  resources :person_certificates
  resources :person_certcourses do
    member do
      post :reset_progress
      post :forget
    end
  end

  resources :action_types
  # resources :activity_types
  resources :badges
  resources :events
  resources :levels
  resources :merchandise
  resources :messages do
    get "hide" => "messages#hide"
    get "unhide" => "messages#unhide"
  end
  resources :message_reports, only: %i[ index update ]
  resources :people
  resources :portal_accesses
  resources :portal_notifications
  resources :posts
  resources :post_reports, only: %i[ index update ]
  resources :products do
    collection do
      get "select_form" => "products#select_form"
      post "select_product" => "products#select"
    end
  end
  # resources :product_beacons
  resources :rooms

  # resources :quests
  # resources :quest_activities
  # resources :quest_completions
  # resources :steps

  get ":product_internal_name/login" => "sessions#new"
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy"
  get ":product_internal_name" => "sessions#login_redirect"

  # get ":product_internal_name/beacons" => "productbeacons#index"
  # get ":product_internal_name/beacons/:id" => "productbeacons#show"
  # post ":product_internal_name/beacons" => "productbeacons#create"
  # post ":product_internal_name/beacons/:id" => "productbeacons#update"

  root to: "people#index"
end
