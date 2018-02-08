Rails.application.routes.draw do
  JkoApi.routes self do
    version 1 do
      resources :badge_actions, only: %i[ create ]
      resources :badges, only: %i[ index ]
      resources :blocks, only: %i[ create destroy ]
      resources :followings, only: %i[ create destroy index ]
      resources :levels, only: %i[ index ]
      resources :people, only: %i[ create show update ] do
        member do
          patch "change_password"
        end
        collection do
          post "password_forgot" => "password_resets#create"
          post "password_reset" => "password_resets#update"
        end
      end
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
    resources :levels
    resources :messages do
      get "hide" => "messages#hide"
      get "unhide" => "messages#unhide"
    end
    resources :people
    resources :posts
    resources :products do
      collection do
        get "select_form" => "products#select_form"
        post "select_product" => "products#select"
      end
    end
    resources :rooms

    get ":product_internal_name/login" => "sessions#new"
    post "login" => "sessions#create"
    get "logout" => "sessions#destroy"
    get ":product_internal_name" => "sessions#login_redirect"

    root to: "people#index"
  end

end
