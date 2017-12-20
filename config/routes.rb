Rails.application.routes.draw do
  JkoApi.routes self do
    version 1 do
      resources :people, only: %i[ create ]
      resources :rooms
      resources :session, only: %i[ create index ] do
        collection do
          delete "" => "session#destroy"
        end
      end
    end
  end

  namespace :admin do
    resources :people
    resources :products
    resources :rooms

    get "login" => "sessions#new"
    post "login" => "sessions#create"
    get "logout" => "sessions#destroy"

    root to: "products#index"
  end

end
