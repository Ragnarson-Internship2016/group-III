Rails.application.routes.draw do
  match "/404", to: 'errors#not_found', via: :all
  match "/422", to: 'errors#validation_error', via: :all
  devise_for :users
  get "about", to: "static_pages#about"
  resources :users
  root to: "events#index"
  resources :events
end
