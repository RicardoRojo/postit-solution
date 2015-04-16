PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  get '/login', to: "sessions#new", as: "login"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  get '/register', to: "users#new", as: "register"

  resources :users, only: [:show,:create,:edit,:update]

  resources :posts, except: [:destroy] do
    member do
      post "vote"
    end
    resources :comments, only: [:create]
  end

  resources :comments do
    member do
      post "vote"
    end
  end
  resources :categories, only: [:show,:new,:create]
end
