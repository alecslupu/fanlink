Rails.application.routes.draw do
  namespace :admin do
    resources :people
    resources :products

    get "login" => "sessions#new"
    post "login" => "sessions#create"
    get "logout" => "sessions#destroy"

    root to: "products#index"
  end

end
