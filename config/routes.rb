Metaphor::Application.routes.draw do

  root :to => 'home#index'
  
  #Admin routes
  namespace :admin do
    resources :articles
    resources :categories
    resources :series
    resources :users
    resources :roles
  end
  
  match 'admin' => 'admin/articles#index'
  match 'admin/articles/checkslug' => 'admin/articles#checkslug'
  match 'admin/articles/:id/default_image_sizes' => 'admin/articles#default_image_sizes', :as => 'admin_article_default_image_sizes'
  match 'admin/articles/:id/preview' => 'admin/articles#preview', :as => 'admin_article_preview'
  
  
  # Public routes
  resources :articles, :only => [:index, :show]  
  match 'articles/:id/preview' => 'articles#preview', :as => 'article_preview'
  
  resources :indexes, :only => [:index]  
  match 'indexes/:id/preview' => 'indexes#preview', :as => 'index_preview'
  
  
  # Authentication routes
  resources :sessions

  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  
  # Glob for pages
  
end
