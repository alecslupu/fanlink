Rails.application.routes.draw do
  scope(constraints: Routing::Constraints::V2, module: "api/v2", defaults: {format: :json}) do
    resources :events, only: %i[create update destroy]

    resources :merchandise, only: %i[create update destroy]

    resources :activities, controller: "quest_activities", only: %i[update show destroy] do
      resources :types, controller: "activity_types", only: %i[create index]
    end

    resources :activity_types, only: %i[show update destroy] do
      collection do
        get "select" => "activity_types#index"
      end
    end

    resources :people, except: %i[create index show update] do
      get "badges" => "badges#index"
    end

    resources :beacons, controller: "product_beacons" do
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
      resources :steps, only: %i[create index]
      resources :completions, controller: "quest_completions", only: %i[create index]
      collection do
        get "list" => "quests#list"
        get "select" => "quests#index"
      end
    end

    resources :completions, controller: "quest_completions", only: %i[index update show] do
      collection do
        get "list" => "quest_completions#list"
      end
    end
    resources :steps, only: %i[show update destroy] do
      resources :activities, controller: "quest_activities", only: %i[create index]
      resources :completions, controller: "quest_completions", only: %i[create index]
    end
    resources :tags, only: %i[index]

    resources :badge_actions, only: %i[create]
    resources :badges, only: %i[index]
    resources :blocks, only: %i[create destroy]
    resources :events, only: %i[index show]
    resources :followings, only: %i[create destroy index]
    resources :levels, only: %i[index]
    resources :merchandise, only: %i[index show]
    get "messages" => "messages#list"
    resources :messages, only: %i[update]
    resources :message_reports, only: %i[index update]
    resources :notification_device_ids, only: %i[create] do
      collection do
        delete "" => "notification_device_ids#destroy"
      end
    end
    resources :people, only: %i[create index show update] do
      member do
        patch "change_password"
      end
      collection do
        post "password_forgot" => "password_resets#create"
        post "password_reset" => "password_resets#update"
        get "recommended" => "recommended_people#index"
        post "send_certificate"
      end
    end
    get "post_comments/list" => "post_comments#list"
    resources :post_reports, only: %i[create index update]
    resources :post_comment_reports, only: %i[create index update]
    resources :posts, except: %i[new edit] do
      collection do
        get "list" => "posts#list"
        get "recommended" => "recommended_posts#index"
      end

      resources :post_comments, only: %i[create destroy index], path: :comments
      resources :post_reactions, only: %i[create destroy index update], path: :reactions
      get "share", on: :member
    end
    resources :relationships, except: %i[new edit]
    resources :rooms do
      resources :messages, except: %i[new edit]
      resources :message_reports, only: %i[create]
      resources :room_memberships, only: %i[create destroy]
    end
    resources :session, only: %i[create index] do
      collection do
        delete "" => "session#destroy"
      end
    end
  end
end
