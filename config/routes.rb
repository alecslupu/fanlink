Rails.application.routes.draw do

   JkoApi.routes self do
     version 1 do
       resources :session, only: %i[ create index ] do
         collection do
           delete "" => "session#destroy"
         end
       end
     end
     #version 2
   end

  namespace :admin do
    resources :people
    resources :products

    get "login" => "sessions#new"
    post "login" => "sessions#create"
    get "logout" => "sessions#destroy"

    root to: "products#index"
  end

end
