class TemplateComponent < ActiveRecord::Base
  attr_accessible :template, :component, :order
  belongs_to :template 
  belongs_to :component
end
