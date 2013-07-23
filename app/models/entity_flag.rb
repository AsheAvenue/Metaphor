class EntityFlag < ActiveRecord::Base
  belongs_to :flaggable, polymorphic: true 
  belongs_to :flag
end
