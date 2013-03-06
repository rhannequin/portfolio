Portfolio::Application.routes.draw do

  root :to => 'projects#index'

  resources :tags
  resources :projects

  match :admin,               :to => 'admin#index'
  get '/admin/login',         :to => 'admin#login', :as => :admin_login
  post '/admin/authenticate', :to => 'admin#authenticate', :as => :admin_authenticate
  namespace :admin do
    resources :tags
    resources :projects
  end
end
