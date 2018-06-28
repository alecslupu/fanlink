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
      get "messages" => "messages#list"
      resources :messages, only: %i[ update ]
      resources :message_reports, only: %i[ index update ]
      resources :notification_device_ids, only: %i[ create ] do
        collection do
          delete "" => "notification_device_ids#destroy"
        end
      end
      resources :people, only: %i[ create index show update ] do
        member do
          patch "change_password"
        end
        collection do
          post "password_forgot" => "password_resets#create"
          post "password_reset" => "password_resets#update"
          get "recommended" => "recommended_people#index"
        end
      end
      get "post_comments/list" => "post_comments#list"
      resources :post_reports, only: %i[ create index update ]
      resources :post_comment_reports, only: %i[ create index update ]
      resources :posts, except: %i[ new edit ] do
        collection do
          get "list" => "posts#list"
          get "recommended" => "recommended_posts#index"
        end
        resources :post_comments, only: %i[ create destroy index ], path: :comments
        resources :post_reactions, only: %i[ create destroy index update ], path: :reactions
        get "share", on: :member
      end
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

    version 2 do
      resources :events, only: %i[ create update destroy ]

      resources :merchandise, only: %i[ create update destroy ]

      resources :activities, :controller => "quest_activities", only: %i[ update show destroy ] do
        resources :types, :controller => "activity_types", only: %i[ create index ]
      end



      resources :activity_types, only: %i[ show update destroy ] do
        collection do
          get "select" => "activity_types#index"
        end
      end

      resources :people, except: %i[ create index show update ] do
        get "badges" => "badges#index"
      end

      resources :beacons, :controller => "product_beacons" do
        collection do
          get "list" => "product_beacons#list"
          get "select" => "product_beacons#index"
        end
      end

      resources :products do
        collection do
          get "select" => "products#index"
        end
      end

      resources :categories do
        collection do
          get "select" => "category#index"
        end
      end

      resources :quests do
        resources :steps, only: %i[ create index ]
        resources :completions, :controller => "quest_completions", only: %i[ create index ]
        collection do
          get "list" => "quests#list"
          get "select" => "quests#index"
        end
      end

      resources :completions, :controller => "quest_completions", only: %i[ update show ] do
        collection do
          get "list" => "quest_completions#list"
        end
      end
      resources :steps, only: %i[ show update destroy ] do
        resources :activities, :controller => "quest_activities", only: %i[ create index ]
        resources :completions, :controller => "quest_completions", only: %i[ create index ]
      end

      resources :tags, only: %i[ show ]
    end

    version 3 do
      resources :action_types do
        collection do
          get "select" => "action_types#index"
          post "complete" => "reward_progresses#create"
        end
      end

      resources :activities, :controller => "quest_activities", except: %i[ create index show update ] do
        collection do
          post "complete" => "reward_progresses#create"
        end
      end

      resources :assigned_rewards, only: %i[ create ]

      resources :quests, except: %i[ create index show update ] do
        collection do
          post "complete" => "reward_progresses#create"
        end
      end

      resources :rewards do
        collection do
          get "select" => "rewards#index"
        end
      end

      resources :steps, except: %i[ create index show update ] do
        collection do
          post "complete" => "reward_progresses#create"
        end
      end

    end

  end

  #temporary hack to get around need for Accept header with api stuff
  # TODO: move the password reset controller update out of the api
  post "/people/password_reset" => "api/v1/password_resets#update"

  #namespace :admin do
    # api_version(:module => "Api::V1::Admin", :path => {:value => "v1"}, :header => {:name => "Accept", :value => "application/vnd.api.v1+json"}, :defaults => {:format => :json}) do

    # end

    # api_version(:module => "Api::V2::Admin", :path => {:value => "v2"}, :header => {:name => "Accept", :value => "application/vnd.api.v2+json"}, :defaults => {:format => :json}) do

    # end

    # api_version(:module => "Api::V3::Admin", :path => {:value => "v3"}, :header => {:name => "Accept", :value => "application/vnd.api.v3+json"}, :defaults => {:format => :json}) do

    # end

    # resources :action_types
    # resources :activity_types
    # resources :badges
    # resources :events
    # resources :levels
    # resources :merchandise
    # resources :messages do
    #   get "hide" => "messages#hide"
    #   get "unhide" => "messages#unhide"
    # end
    # resources :message_reports, only: %i[ index update ]
    # resources :people
    # resources :portal_notifications
    # resources :posts
    # resources :post_reports, only: %i[ index update ]
    # resources :products do
    #   collection do
    #     get "select_form" => "products#select_form"
    #     post "select_product" => "products#select"
    #   end
    # end
    # resources :product_beacons
    # resources :rooms

    # resources :quests
    # resources :quest_activities
    # resources :quest_completions
    # resources :steps


    # get ":product_internal_name/login" => "sessions#new"
    # post "login" => "sessions#create"
    # get "logout" => "sessions#destroy"
    # get ":product_internal_name" => "sessions#login_redirect"

    # get ":product_internal_name/beacons" => "productbeacons#index"
    # get ":product_internal_name/beacons/:id" => "productbeacons#show"
    # post ":product_internal_name/beacons" => "productbeacons#create"
    # post ":product_internal_name/beacons/:id" => "productbeacons#update"

    # root to: "people#index"
  #end

end
