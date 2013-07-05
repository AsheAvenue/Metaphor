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
    resources :templates
    resources :components
    
    #generic admin routes
    match '/' => 'articles#index'
    match 'articles/checkslug' => 'articles#checkslug'
    match 'articles/:id/default_image_sizes' => 'articles#default_image_sizes', :as => 'article_default_image_sizes'
    match 'articles/:id/editor' => 'article_editor#index', :as => 'article_editor'
    match 'articles/:id/editor/select_video' => 'article_editor#select_video', :as => 'article_editor_select_video'
    match 'articles/:id/editor/select_image' => 'article_editor#select_image', :as => 'article_editor_select_image'
    match 'articles/:id/editor/select_sound' => 'article_editor#select_sound', :as => 'article_editor_select_sound'
    match 'collections/:id/sort' => 'collections#sort', :as => 'collection_sort'
    match 'collections/:id/add_pinned_article' => 'collections#add_pinned_article', :as => 'collection_add_pinned_article'
    match 'collections/:id/remove_pinned_article/:pinned_article_id' => 'collections#remove_pinned_article', :as => 'collection_remove_pinned_article'
    match 'templates/:id/sort' => 'templates#sort', :as => 'template_sort'
    match 'templates/:id/add_component' => 'templates#add_component', :as => 'template_add_component'
    match 'templates/:id/remove_component/:component_id' => 'templates#remove_component', :as => 'template_remove_component'
    
    #picker
    match 'picker/addVideo' => 'picker#addVideo'
    match 'picker/addSound' => 'picker#addSound'
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
