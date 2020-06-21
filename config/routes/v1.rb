# frozen_string_literal: true

Rails.application.routes.draw do
  scope(constraints: Routing::Constraints::V1, module: "api/v1", defaults: { format: :json }) do
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
