Rails.application.routes.draw do

  # verification page
  get "/welcome", to: "sessions#welcome"
  post "/welcome", to: "sessions#verify_code"

  # singup page
  get "/registration", to: "sessions#signup"
  post "/registration", to: "sessions#new_session"

  # login page
  get "/login", to: "sessions#login_user"
  post "/login", to: "sessions#new_auth"

  # user profile page
  get "/profile", to: "home#user_profile"
  post "profile", to: "home#add_email"
  delete "profile", to: "home#remove_email"

  # methods to handle donation
  get "/donate/:id", to: "home#donations"
  post "/donate", to: "home#confirm_donations"

  # chat methods
  get "/chat", to: "messages#inbox"
  get "/chat/:id", to: "messages#chat"
  post "/chat/:id", to: "messages#send_message"

  # welocme page
  root "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
