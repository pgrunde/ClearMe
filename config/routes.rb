Rails.application.routes.draw do
  root "dashboard#show"

  resources :external_users
  resources :inhouse_users
  resources :jobs
  resources :forms

  get "inhouse_signin" => "inhouse_sessions#new", as: :inhouse_signin
  post "inhouse_signin" => "inhouse_sessions#create"
  delete "inhouse_signout" => "inhouse_sessions#destroy", as: :inhouse_signout

  get "external_signin" => "external_sessions#new", as: :external_signin
  post "external_signin" => "external_sessions#create"
  delete "external_signout" => "external_sessions#destroy", as: :external_signout


  get "inhouse_contracts" => "inh_ext_contracts#inh_index"
  get "external_contracts" => "inh_ext_contracts#ext_index"
  get "search_for_ext" => "inh_ext_contracts#search_for_ext"
  get "view_pending_contracts" => "inh_ext_contracts#view_pending_contracts", as: "view_pending_contracts"
  post "/search_for_ext/:id" => "inh_ext_contracts#inh_create", as: "inh_request_contract"
  patch "ext_send_contract/:id" => "inh_ext_contracts#ext_send_contract", as: "ext_send_contract"

  get "inh_mainpage" => "inh_mainpage#show"
  get "ext_mainpage" => "ext_mainpage#show"

end
