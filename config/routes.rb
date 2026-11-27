Rails.application.routes.draw do
    get "up" => "rails/health#show", as: :rails_health_check

    resources :spots, only: [:index, :show]
    root "home#top"
    
    get    "signup", to: "users#new"
    resources :users, only: [:create]

    get    "login",  to: "sessions#new"
    post   "login",  to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    namespace :admin do
        root "dashboard#index"
    end
end
