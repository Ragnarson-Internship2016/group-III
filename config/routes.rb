Rails.application.routes.draw do
  match "/404", to: 'errors#not_found', via: :all
  match "/422", to: 'errors#validation_error', via: :all
  devise_for :users
  root to: "home#index"
  resources :users
end
