Metaphor::Application.routes.draw do

  root :to => 'home#index'
  match '/admin' => 'admin/articles#index'
  match "/admin/articles/checkslug" => 'admin/articles#checkslug'
  match '/admin/articles/:id/default_image_sizes' => 'admin/articles#default_image_sizes', :as => 'admin_article_default_image_sizes'
  match '/admin/articles/:id/preview' => 'admin/articles#preview', :as => 'admin_article_preview'
  
  #Admin controllers
  namespace :admin do
    resources :articles
    resources :categories
    resources :series
    resources :users
    resources :roles
  end
  
  # A non-admin articles controller, used simply for displaying articles
  resources :articles, :only => [:index, :show]
  
  # Authentication
  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  resources :sessions
  
end
