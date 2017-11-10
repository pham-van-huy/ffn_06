Rails.application.routes.draw do
  root "news#index"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login/facebook", to: "sessions#facebook"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "searchs#show"
  resources :users, only: [:edit, :update]
  resources :news, only: :show
  resources :comments, only: [:create, :update, :destroy]
  resources :teams, only: :index
  resources :leagues, only: [:index, :show]
  resources :bets, only: [:create, :update, :destroy]
  resources :matchs, only: :show
  namespace :admin do
    get "/", to: "leagues#home_admin"
    get "/ajax_get_countries", to: "countries#get_by_league"
    resources :leagues, except: :show do
      resources :matchs, only: [:create, :new, :index]
    end
    resources :news, except: :show
  end
end
