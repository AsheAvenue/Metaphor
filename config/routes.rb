Metaphor::Application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'

  root :to => 'home#index'
  
  #Admin routes
  namespace :admin do
    resources :articles
    resources :categories
    resources :series
    resources :related_parties
    resources :collections
    resources :pinned_articles
    resources :pages
    resources :users
    resources :roles
  
    #generic admin routes
    match '/' => 'articles#index'
    match 'articles/checkslug' => 'articles#checkslug'
    match 'articles/:id/default_image_sizes' => 'articles#default_image_sizes', :as => 'article_default_image_sizes'
    match 'articles/:id/preview' => 'articles#preview', :as => 'article_preview'
    match 'collections/:id/sort' => 'collections#sort', :as => 'collection_sort'
    
    #picker
    match 'picker/:action' => 'picker#:action'
  end
  
  
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
  get '/:id' => 'pages#show', :as => 'page'
end
