Rails.application.routes.draw do

  # verification page 
  get '/welcome', to: "sessions#welcome"
  post '/welcome', to: "sessions#verify_code"

  # singup page 
  get '/registration', to: "sessions#signup"
  post '/registration', to: "sessions#new_session"


  # user profile page 
  get '/profile', to: 'home#user_profile'


  # welocme page 
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
