Metaphor::Engine.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'
  root :to => 'articles#index', :as => 'metaphor'
  
  resources :articles
  resources :events
  resources :categories
  resources :series
  resources :flags
  resources :collections
  resources :pinned_entities
  resources :pages
  resources :templates
  resources :components
  resources :users
  resources :roles
  resources :sessions
  resource  :site, controller: 'site'
  
  match 'articles/checkslug' => 'articles#checkslug'
  match 'articles/search' => 'articles#search', :as => 'article_search'
  match 'articles/vote' => 'articles#vote', :as => 'article_vote'
  match 'articles/:id/version/:version_id' => 'articles#revision', :as => 'article_revision'
  match 'articles/:id/publish/version/:version_id' => 'articles#publish', :as => 'article_publish'
  match 'articles/:id/unpublish' => 'articles#unpublish', :as => 'article_unpublish'
  match 'articles/:id/schedule/version/:version_id' => 'articles#schedule', :as => 'article_schedule'
  match 'articles/:id/unschedule' => 'articles#unschedule', :as => 'article_unschedule'
  match 'articles/:id/editor' => 'article_editor#index', :as => 'article_editor'
  match 'articles/:id/editor/version/:version_id' => 'article_editor#index', :as => 'article_editor_version'
  match 'articles/:id/editor/select_video' => 'article_editor#select_video', :as => 'article_editor_select_video'
  match 'articles/:id/editor/select_image' => 'article_editor#select_image', :as => 'article_editor_select_image'
  match 'articles/:id/editor/select_gallery' => 'article_editor#select_gallery', :as => 'article_editor_select_gallery'
  match 'articles/:id/editor/select_sound' => 'article_editor#select_sound', :as => 'article_editor_select_sound'
  match 'articles/:id/editor/update_body' => 'article_editor#update_body', :as => 'article_editor_update_body'
  match 'articles/:id/editor/get_image_for_body' => 'article_editor#get_image_for_body', :as => 'article_editor_get_image_for_body'
  match 'articles/:id/editor/get_video_for_body' => 'article_editor#get_video_for_body', :as => 'article_editor_get_video_for_body'
  match 'articles/:id/editor/get_sound_for_body' => 'article_editor#get_sound_for_body', :as => 'article_editor_get_sound_for_body'
  match 'articles/taglist/:term' => 'articles#taglist', :as => 'article_tag_list'
  match 'articles/related_entity_list/:related_entity/:term' => 'articles#related_entity_list'
  
  match 'events/taglist/:term' => 'events#taglist', :as => 'event_tag_list'
  match 'events/related_entity_list/:related_entity/:term' => 'events#related_entity_list'
  
  match 'galleries/:id/editor' => 'gallery_editor#index', :as => 'gallery_editor'
  match 'galleries/:id/sort' => 'gallery_editor#sort', :as => 'gallery_sort'
  match 'galleries/add_image' => 'gallery_editor#add_image', :as => 'gallery_editor_add_image'
  match 'galleries/remove_image' => 'gallery_editor#remove_image', :as => 'gallery_editor_remove_image'
  match 'galleries/save_image' => 'gallery_editor#save_image', :as => 'gallery_editor_save_image'
  match 'galleries/select_image' => 'gallery_editor#select_image', :as => 'gallery_editor_select_image'
  match 'galleries/image_info/:id' => 'gallery_editor#image_info', :as => 'gallery_editor_image_info'
  
  match 'collections/:id/sort' => 'collections#sort', :as => 'collection_sort'
  match 'collections/:id/add_pinned_entity' => 'collections#add_pinned_entity', :as => 'collection_add_pinned_entity'
  match 'collections/:id/remove_pinned_entity/:pinned_entity_id' => 'collections#remove_pinned_entity', :as => 'collection_remove_pinned_entity'
  
  match 'templates/:id/sort' => 'templates#sort', :as => 'template_sort'
  match 'templates/:id/add_component' => 'templates#add_component', :as => 'template_add_component'
  match 'templates/:id/remove_component/:component_id' => 'templates#remove_component', :as => 'template_remove_component'

  match 'picker/addVideo' => 'picker#addVideo', :as => 'picker_add_video'
  match 'picker/addSound' => 'picker#addSound', :as => 'picker_add_sound'
  match 'picker/addImage' => 'picker#addImage', :as => 'picker_add_image'
  match 'picker/addGallery' => 'picker#addGallery', :as => 'picker_add_gallery'
  match 'picker/searchVideo' => 'picker#searchVideo'
  match 'picker/searchSound' => 'picker#searchSound'
  match 'picker/searchImage' => 'picker#searchImage'
  match 'picker/searchGallery' => 'picker#searchGallery'
  match 'picker/:action' => 'picker#:action', :as => 'picker'

  match "social/tumblr" => 'social#tumblr', :as => 'tumblr'
  match "social/twitter" => 'social#twitter', :as => 'twitter'
  match "social/instagram" => 'social#instagram', :as => 'instagram'
  
  get "signout" => "sessions#destroy", :as => "signout"
  get "signin" => "sessions#new", :as => "signin"
  
end
