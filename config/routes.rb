Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :players, controllers: { registrations: 'players/registrations' }
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root 'home#index'

  namespace :players do
    resources :home, path: 'my-page', only: [:index]
  end

  resources :matches, only: %i[new create] do
    resources :game_boards, only: %i[edit], controller: 'matches/game_boards' do
      resources :spacecraft_positions, only: %i[new create],
                                       controller: 'matches/game_boards/'\
                                                   'spacecraft_positions'
    end
    get :awaiting_challenge
    post :join
  end
end
