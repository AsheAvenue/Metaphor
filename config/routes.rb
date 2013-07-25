Metaphor::Engine.routes.draw do

  root :to => 'articles#index', :as => 'metaphor'
  
  resources :articles
  resources :categories
  resources :series
  resources :flags
  resources :related_parties
  resources :collections
  resources :pinned_articles
  resources :pages
  resources :templates
  resources :components
  resources :users
  resources :roles
  resources :sessions
  
  match 'articles/checkslug' => 'articles#checkslug'
  match 'articles/:id/revision/:version_index' => 'articles#revision', :as => 'article_revision'
  match 'articles/:id/publish/revision/:version_index' => 'articles#publish', :as => 'article_publish'
  match 'articles/:id/unpublish' => 'articles#unpublish', :as => 'article_unpublish'
  match 'articles/:id/schedule/revision/:version_index' => 'articles#schedule', :as => 'article_schedule'
  match 'articles/:id/unschedule' => 'articles#unschedule', :as => 'article_unschedule'
  match 'articles/:id/editor' => 'article_editor#index', :as => 'article_editor'
  match 'articles/:id/editor/select_video' => 'article_editor#select_video', :as => 'article_editor_select_video'
  match 'articles/:id/editor/select_image' => 'article_editor#select_image', :as => 'article_editor_select_image'
  match 'articles/:id/editor/select_gallery' => 'article_editor#select_gallery', :as => 'article_editor_select_gallery'
  match 'articles/:id/editor/select_sound' => 'article_editor#select_sound', :as => 'article_editor_select_sound'
  match 'articles/:id/editor/update_body' => 'article_editor#update_body', :as => 'article_editor_update_body'
  match 'articles/taglist/:term' => 'articles#taglist', :as => 'article_tag_list'
  match 'galleries/:id/editor' => 'gallery_editor#index', :as => 'gallery_editor'
  match 'galleries/:id/sort' => 'gallery_editor#sort', :as => 'gallery_sort'
  match 'galleries/add_image' => 'gallery_editor#add_image', :as => 'gallery_editor_add_image'
  match 'galleries/remove_image' => 'gallery_editor#remove_image', :as => 'gallery_editor_remove_image'
  match 'galleries/save_image' => 'gallery_editor#save_image', :as => 'gallery_editor_save_image'
  match 'galleries/select_image' => 'gallery_editor#select_image', :as => 'gallery_editor_select_image'
  match 'galleries/image_info/:id' => 'gallery_editor#image_info', :as => 'gallery_editor_image_info'
  match 'collections/:id/sort' => 'collections#sort', :as => 'collection_sort'
  match 'collections/:id/add_pinned_article' => 'collections#add_pinned_article', :as => 'collection_add_pinned_article'
  match 'collections/:id/remove_pinned_article/:pinned_article_id' => 'collections#remove_pinned_article', :as => 'collection_remove_pinned_article'
  match 'templates/:id/sort' => 'templates#sort', :as => 'template_sort'
  match 'templates/:id/add_component' => 'templates#add_component', :as => 'template_add_component'
  match 'templates/:id/remove_component/:component_id' => 'templates#remove_component', :as => 'template_remove_component'
  match 'picker/addVideo' => 'picker#addVideo', :as => 'picker_add_video'
  match 'picker/addSound' => 'picker#addSound', :as => 'picker_add_sound'
  match 'picker/addImage' => 'picker#addImage', :as => 'picker_add_image'
  match 'picker/addGallery' => 'picker#addGallery', :as => 'picker_add_gallery'
  match 'picker/:action' => 'picker#:action', :as => 'picker'
  match "social/tumblr" => 'social#tumblr', :as => 'tumblr'
  match "social/twitter" => 'social#twitter', :as => 'twitter'
  match "social/instagram" => 'social#instagram', :as => 'instagram'
  
  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  
  # Glob for pages
  get '/:id' => 'pages#show', :as => 'page'
  
end
