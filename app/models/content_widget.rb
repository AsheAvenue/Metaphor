class ContentWidget < ActiveRecord::Base
  attr_accessible :content_id, :content_type, :entity_id, :entity_type, :position
  
  belongs_to :entity, :polymorphic => true, :foreign_key => :entity_id
  belongs_to :content, :polymorphic => true, :foreign_key => :content_id
end
