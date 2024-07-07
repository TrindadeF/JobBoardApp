Rails.application.routes.draw do
  resources :jobs
  devise_for :users
  resources :jobs
  root to: "jobs#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
