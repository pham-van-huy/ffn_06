Rails.application.routes.draw do
  root "news#index"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:edit, :update]
  resources :news, only: [:show]
  resources :comments, only: [:create, :update, :destroy]
  resources :teams, only: [:index]
end
