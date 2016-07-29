Rails.application.routes.draw do
  match "/404", to: 'errors#not_found', via: :all
  match "/422", to: 'errors#validation_error', via: :all
  devise_for :users
  get "about", to: "static_pages#about"
  resources :users
  root to: "static_pages#landing_page"
  resources :events do
    member do
      post :join
      post :leave
    end
    resources :games, except: [:index] do
      collection do
        get "search"
      end
    end
  end
  resources :comments, only: [:create]
end
