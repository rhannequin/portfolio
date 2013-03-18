Portfolio::Application.routes.draw do

  root :to => 'projects#index'

  # Portfolio
  match 'portfolio',        :to => 'portfolio#index',    :as => :portfolio
  match 'portfolio/:id',    :to => 'portfolio#show',     :as => :show_portfolio

  resources :tags
  resources :projects

  match :admin,               :to => 'admin#index'
  get '/admin/login',         :to => 'admin#login',        :as => :admin_login
  post '/admin/authenticate', :to => 'admin#authenticate', :as => :admin_authenticate
  namespace :admin do
    resources :tags
    resources :projects
  end
end
