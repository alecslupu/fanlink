Rails.application.routes.draw do

   JkoApi.routes self do
     version 1 do
       resources :session, only: %i[ create destroy index ]
     end
   end

  #delete "session" => "api/v1/session#destroy"
  #get "session" => "api/v1/session#index"
  #post "session" => "api/v1/session#create"
  #
  namespace :admin do
    resources :people
    resources :products

    get "login" => "sessions#new"
    post "login" => "sessions#create"
    get "logout" => "sessions#destroy"

    root to: "products#index"
  end

end
