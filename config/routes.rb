PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  get '/login', to: "sessions#new", as: "login"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  get '/register', to: "users#new", as: "register"

  resources :users, only: [:create]

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end
  resources :categories, only: [:show,:new,:create]
end
