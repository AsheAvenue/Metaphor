$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "metaphor"
  s.version     = "0.5.2"
  s.authors     = ["Tim Boisvert"]
  s.email       = ["tboisvert@asheavenue.com"]
  s.homepage    = "http://www.asheavenue.com"
  s.summary     = "Editorial Platform"
  s.description = "Editorial Platform"

  s.files = Dir["{app,config,lib}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '3.2.13'
  s.add_dependency 'pg'
  s.add_dependency 'rails_config'
  s.add_dependency 'sorcery'
  s.add_dependency 'rmagick'
  s.add_dependency 'rolify'
  s.add_dependency 'cancan'
  s.add_dependency 'filepicker-rails'
  s.add_dependency 'aws-sdk'
  s.add_dependency 'paperclip'
  s.add_dependency 'uglifier', '>= 1.0.3'
  s.add_dependency 'paper_trail'
  s.add_dependency 'instagram'
  s.add_dependency 'twitter'
  s.add_dependency 'tumblr-rb'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'whenever'
  s.add_dependency 'pg_search'
  s.add_dependency 'carrierwave' #needed for redactor
  s.add_dependency 'mini_magick' #needed for redactor  
  s.add_dependency 'redactor-rails'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'feedzirra'
  s.add_dependency 'rinku'
  
  s.add_development_dependency 'better_errors'
  s.add_development_dependency 'binding_of_caller'
  s.add_development_dependency 'meta_request'
  
end
