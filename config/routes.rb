Portfolio::Application.routes.draw do

  root :to => 'pages#home'

  # Portfolio
  match 'portfolio',        :to => 'portfolio#index',  :as => :portfolio
  match 'portfolio/:slug',  :to => 'portfolio#show',   :as => :show_portfolio

  match 'contact' => 'pages#contact', :as => 'contact', :via => :get
  match 'contact' => 'pages#send_contact', :as => 'contact', :via => :post

  resources :projects

  match     :admin,                :to => 'admin#index'
  get       '/admin/login',        :to => 'admin#login',        :as => :admin_login
  post      '/admin/authenticate', :to => 'admin#authenticate', :as => :admin_authenticate
  namespace :admin do
    resources :tags

    # To fix: DELETE method doesn't get session current_user
    # in order to be allowed to go to admin/projects#destroy action
    get '/admin/projects/destroy/:id', :to => 'projects#destroy'

    resources :projects
  end

  match '/curriculum-vitae', :to => 'pages#curriculum_vitae'
  match '/:action', :controller => 'pages'
end
