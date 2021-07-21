Rails.application.routes.draw do
  get '/registration', to: "sessions#signup"
  post '/registration', to: "sessions#new_session"
  get '/profile', to: 'home#user_profile'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
