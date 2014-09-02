Rails.application.routes.draw do
  root "dashboard#show"

  resources :external_users
  resources :inhouse_users

  get "inhouse_signin" => "inhouse_sessions#new", as: :inhouse_signin
  post "inhouse_signin" => "inhouse_sessions#create"
  delete "inhouse_signout" => "inhouse_sessions#destroy", as: :inhouse_signout

  get "external_signin" => "external_sessions#new", as: :external_signin
  post "external_signin" => "external_sessions#create"
  delete "external_signout" => "external_sessions#destroy", as: :external_signout

  get "inh_mainpage" => "inh_mainpage#show"

  resources :forms

  get "ext_mainpage" => "ext_mainpage#show"

end
