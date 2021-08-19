Rails.application.routes.draw do
  devise_for :users
  root "reservations#index"
  resources :reservations, only: [:index, :new, :create]
end
