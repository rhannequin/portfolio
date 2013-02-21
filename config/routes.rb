Portfolio::Application.routes.draw do

  root :to => 'projects#index'

  resources :tags
  resources :projects

  match :admin, :to => 'admin#index'
  namespace :admin do
    resources :tags
    resources :projects
  end
end
