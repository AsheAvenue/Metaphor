class TemplateComponent < ActiveRecord::Base
  belongs_to :template 
  belongs_to :component
end
