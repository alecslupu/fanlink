Rails.application.routes.draw do
  JkoApi.routes self do
    version 1 do
      resources :badge_actions, only: %i[ create ]
      resources :badges, only: %i[ index ]
      resources :blocks, only: %i[ create destroy ]
      resources :events, only: %i[ index show ]
      resources :followings, only: %i[ create destroy index ]
      resources :levels, only: %i[ index ]
      resources :merchandise, only: %i[ index show ]
      resources :message_reports, only: %i[ update ]
      resources :notification_device_ids, only: %i[ create ] do
        collection do
          delete "" => "notification_device_ids#destroy"
        end
      end
      resources :people, only: %i[ create show update ] do
        member do
          patch "change_password"
        end
        collection do
          post "password_forgot" => "password_resets#create"
          post "password_reset" => "password_resets#update"
          get "recommended" => "recommended_people#index"
        end
      end
      resources :posts, except: %i[ new edit ] do
        resources :post_reactions, only: %i[ create destroy index update ], path: :reactions
      end
      resources :post_reports, only: %i[ create ]
      resources :relationships, except: %i[ new edit ]
      resources :rooms do
        resources :messages, except: %i[ new edit ]
        resources :message_reports, only: %i[ create ]
        resources :room_memberships, only: %i[ create destroy ]
      end
      resources :session, only: %i[ create index ] do
        collection do
          delete "" => "session#destroy"
        end
      end
    end
  end

  #temporary hack to get around need for Accept header with api stuff
  # TODO: move the password reset controller update out of the api
  post "/people/password_reset" => "api/v1/password_resets#update"

  namespace :admin do
    resources :action_types
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
    resources :posts
    resources :post_reports, only: %i[ index update ]
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
