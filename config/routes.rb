Metaphor::Application.routes.draw do
  
  get "article/index"

  get "article/show"

  root :to => 'home#index'
  match '/admin' => 'admin/home#index'
  match "/admin/articles/checkslug" => 'admin/articles#checkslug'
  
  namespace :admin do
    resources :articles
    resources :categories
    resources :series
  end
  
end
