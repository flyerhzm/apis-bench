LeaderboardRails::Application.routes.draw do
  resources :games, only: [] do
    resources :leaderboards, only: [:index, :show, :create, :update]
  end

  resources :leaderboards, only: [] do
    resources :users, only: [:index, :show]
  end
end
