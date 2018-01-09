Rails.application.routes.draw do
  JkoApi.routes self do
    version 1 do
      resources :followings, only: %i[ create destroy ]
      resources :people, only: %i[ create ]
      resources :rooms do
        resources :messages, except: %i[ new edit ]
        resources :room_memberships, only: %i[ create destroy ]
      end
      resources :session, only: %i[ create index ] do
        collection do
          delete "" => "session#destroy"
        end
      end
    end
  end

  namespace :admin do
    resources :messages do
      get "hide" => "messages#hide"
      get "unhide" => "messages#unhide"
    end
    resources :people
    resources :products
    resources :rooms

    get "login" => "sessions#new"
    post "login" => "sessions#create"
    get "logout" => "sessions#destroy"

    root to: "products#index"
  end

end
