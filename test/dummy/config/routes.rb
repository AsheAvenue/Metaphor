Rails.application.routes.draw do

  mount Metaphor::Engine => '/admin'
  
end
