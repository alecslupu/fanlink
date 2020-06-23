# frozen_string_literal: true

Rails.application.routes.draw do
  scope(constraints: Routing::Constraints::V4, module: 'api/v4', defaults: { format: :json }) do
    resources :people, except: %i[create index show update] do
      collection do
        resources :referral, path: :referral, only: [:index], module: 'referral' do
          collection do
            get :purchased
            get '/me' => 'user_code#index'
          end
        end
      end
    end

    resources :session, only: %i[create index] do
      post :token, on: :collection
    end

    # to be modified
    resources :certificates do
      resources :certcourses, only: [:index]
    end

    resources :certcourses, only: [:show, :create, :destroy] do
      resources :certcourse_pages, only: [:send_email]
    end
    resources :person_certificates, only: [:create] do
      collection do
        get ':unique_id' => 'person_certificates#show'
      end
    end
    resources :person_certcourses, only: [:create, :send_email] do
      collection do
        post :send_email
      end
    end

    resources :messages, except: %i[create index show update] do
      collection do
        get 'stats' => 'messages#stats'
      end
    end
    resources :people, except: %i[create index show update] do
      collection do
        get 'stats' => 'people#stats'
        get 'person/:username' => 'people#show'
      end
    end

    resources :followings, only: %i[index]
    resources :posts, only: %i[index] do
      collection do
        get 'stats' => 'posts#stats'
      end
    end
    resources :interests do
      collection do
        get 'match' => 'interests#match'
      end
    end

    namespace :courseware do
      namespace :client do
        resources :people, only: [:index] do
          resources :certificates, only: [:index, :show] do
            member do
              post 'send_email'
              get 'download'
            end
            resources :certcourses, only: [:index, :show]
          end
        end
      end
      resources :wishlists, only: [:index, :create, :destroy]
    end
    resources :notifications, only: [:create]

    resources :action_types do
      collection do
        get 'select' => 'action_types#index'
        post 'complete' => 'reward_progresses#create'
      end
    end

    resources :activities, controller: 'quest_activities', except: %i[create index show update] do
      collection do
        post 'complete' => 'reward_progresses#create'
      end
    end

    resources :assigned_rewards, only: %i[create update destroy]

    resources :badges, except: %i[destroy]

    resources :events do
      member do
        post 'checkins' => 'events#checkin'
        delete 'checkins' => 'events#checkout'
        get 'checkins' => 'events#checkins'
      end
    end
    resources :courses, except: %i[index create] do
      get 'lessons' => 'lessons#index'
      post 'lessons' => 'lessons#create'
    end

    resources :interests do
      member do
        post 'add' => 'interests#add_interest'
        post 'remove' => 'interests#remove_interest'
      end
    end

    resources :lessons, except: %i[index create]

    resources :people, only: %i[create index show update destroy] do
      member do
        get 'interests' => 'people#interests'
        get 'public' => 'people#public'
        patch 'change_password'
      end
      collection do
        post 'password_forgot' => 'password_resets#create'
        post 'password_reset' => 'password_resets#update'
        get 'recommended' => 'recommended_people#index'
      end
      post 'pin' => 'pin_messages#pin_to'
    end

    resources :pin_messages, only: %i[destroy], path: :pinned

    resources :portal_notifications

    resources :posts, except: %i[new edit] do
      resources :polls, controller: 'polls', only: %i[create update destroy] do
        resources :poll_options, controller: 'poll_options', only: %i[create update list destroy] do
          post '/cast_vote' => 'poll_options#cast_vote'
          delete '/delete_votes' => 'poll_options#delete_votes'
        end
      end
      collection do
        get 'list' => 'posts#list'
        get 'recommended' => 'recommended_posts#index'
        get 'tags' => 'tags#index'
        get 'category/:category_name' => 'categories#posts'
      end
      get 'share' => 'posts#share'
    end

    resources :polls, only: %i[index] do
      resources :poll_options, controller: 'poll_options', only: %i[show index cast_vote]
    end

    resources :quests, except: %i[create index show update] do
      collection do
        post 'complete' => 'reward_progresses#create'
      end
    end

    resources :rewards do
      collection do
        get 'select' => 'rewards#index'
      end
      get 'assigned' => 'assigned_rewards#index'
    end

    resources :rooms do
      post 'pin' => 'pin_messages#pin_from'
    end

    resources :semesters do
      get 'courses' => 'courses#index'
      post 'courses' => 'courses#create'
    end

    resources :steps, except: %i[create index show update] do
      collection do
        post 'complete' => 'reward_progresses#create'
      end
    end

    resources :events, only: %i[create update destroy]

    resources :merchandise, only: %i[create update destroy]

    resources :activities, controller: 'quest_activities', only: %i[update show destroy] do
      resources :types, controller: 'activity_types', only: %i[create index]
    end

    resources :activity_types, only: %i[show update destroy] do
      collection do
        get 'select' => 'activity_types#index'
      end
    end

    resources :people, except: %i[create index show update] do
      get 'badges' => 'badges#index'
    end

    resources :beacons, controller: 'product_beacons' do
      collection do
        get 'list' => 'product_beacons#list'
        get 'select' => 'product_beacons#index'
      end
    end

    resources :products do
      collection do
        get 'select' => 'products#index'
      end
    end

    resources :categories do
      collection do
        get 'select' => 'category#index'
      end
    end

    resources :quests do
      resources :steps, only: %i[create index]
      resources :completions, controller: 'quest_completions', only: %i[create index]
      collection do
        get 'list' => 'quests#list'
        get 'select' => 'quests#index'
      end
    end

    resources :completions, controller: 'quest_completions', only: %i[index update show] do
      collection do
        get 'list' => 'quest_completions#list'
      end
    end
    resources :steps, only: %i[show update destroy] do
      resources :activities, controller: 'quest_activities', only: %i[create index]
      resources :completions, controller: 'quest_completions', only: %i[create index]
    end
    resources :tags, only: %i[index]

    resources :badge_actions, only: %i[create]
    resources :badges, only: %i[index]
    resources :blocks, only: %i[create destroy]
    resources :events, only: %i[index show]
    resources :followings, only: %i[create destroy index]
    resources :levels, only: %i[index]
    resources :merchandise, only: %i[index show]
    get 'messages' => 'messages#list'
    resources :messages, only: %i[update]
    resources :message_reports, only: %i[index update]
    resources :notification_device_ids, only: %i[create] do
      collection do
        delete '' => 'notification_device_ids#destroy'
      end
    end
    resources :people, only: %i[create index show update] do
      member do
        patch 'change_password'
      end
      collection do
        post 'password_forgot' => 'password_resets#create'
        post 'password_reset' => 'password_resets#update'
        get 'recommended' => 'recommended_people#index'
        post 'send_certificate'
      end
    end
    get 'post_comments/list' => 'post_comments#list'
    resources :post_reports, only: %i[create index update]
    resources :post_comment_reports, only: %i[create index update]
    resources :posts, except: %i[new edit] do
      collection do
        get 'list' => 'posts#list'
        get 'recommended' => 'recommended_posts#index'
      end

      resources :post_comments, only: %i[create destroy index], path: :comments
      resources :post_reactions, only: %i[create destroy index update], path: :reactions
      get 'share', on: :member
    end
    resources :relationships, except: %i[new edit]
    resources :rooms do
      resources :messages, except: %i[new edit]
      resources :message_reports, only: %i[create]
      resources :room_memberships, only: %i[create destroy]
    end
    resources :session, only: %i[create index] do
      collection do
        delete '' => 'session#destroy'
      end
    end
    namespace :trivia do
      resources :picture_available_answers, only: [:show]
      resources :games, only: [:index] do
        get :completed, on: :collection

        resource :subscription, except: [:new, :edit]

        resources :prizes, only: [:index]

        resources :rounds, only: [:index] do
          post :change_status
          resources :round_leaderboards, path: :leaderboard, only: [:index] do
            get :me, on: :collection
          end
        end
        resources :game_leaderboards, path: :leaderboard, only: [:index] do
          get :me, on: :collection
        end
      end
    end
  end
end

