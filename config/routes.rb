Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :players, controllers: { registrations: 'players/registrations' }
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root 'home#index'

  namespace :players do
    resources :home, path: 'my-page', only: [:index]
    resources :matches, only: %i[new create] do
      get :awaiting_challenge
    end
  end
end
