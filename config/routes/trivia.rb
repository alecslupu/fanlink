JkoApi.routes self do
  version 4 do
    namespace :trivia do
      resources :games, only: [ :index ] do
        get :completed, on: :collection

        resources :prizes, only: [ :index ]

        resources :rounds, only: [ :index ] do
          resources :round_leaderboards, path: :leaderboard, only: [ :index ] do
            get :me, on: :collection
          end
        end
        resources :game_leaderboards, path: :leaderboard, only: [ :index ] do
          get :me, on: :collection
        end

      end
    end
  end

  version 5 do

  end
end
