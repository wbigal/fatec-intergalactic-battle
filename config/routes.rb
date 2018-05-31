Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :players, controllers: { registrations: 'players/registrations' }
  devise_for :users

  root 'home#index'
end
