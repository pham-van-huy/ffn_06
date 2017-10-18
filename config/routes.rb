Rails.application.routes.draw do
  root "application#home"
  get "/signup", to: "users#new"
end
