Metaphor::Application.routes.draw do

  root :to => 'home#index'
  match '/admin' => 'admin/home#index'
  match "/admin/articles/checkslug" => 'admin/articles#checkslug'
  
  namespace :admin do
    resources :articles
    resources :categories
    resources :series
    resources :users
    resources :roles
  end
  
  # auth
  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  get "signup" => "users#new", :as => "signup"
  resources :sessions
  
end
