Rails.application.routes.draw do
  JkoApi.routes self do
    version 1 do
      resources :badge_actions, only: %i[ create ]
      resources :followings, only: %i[ create destroy index ]
      resources :people, only: %i[ create ]
      resources :posts, except: %i[ new edit ]
      resources :relationships, except: %i[ new edit ]
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
    resources :action_types
    resources :badges
    resources :messages do
      get "hide" => "messages#hide"
      get "unhide" => "messages#unhide"
    end
    resources :people
    resources :posts
    resources :products
    resources :rooms

    get "login" => "sessions#new"
    post "login" => "sessions#create"
    get "logout" => "sessions#destroy"

    root to: "products#index"
  end

end
