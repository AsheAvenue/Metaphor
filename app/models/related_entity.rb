class RelatedEntity < ActiveRecord::Base
  attr_accessible :entity_id, :entity_type, :related_id, :related_type
    
  belongs_to :entity, :polymorphic => true, :foreign_key => :entity_id
  belongs_to :related, :polymorphic => true, :foreign_key => :related_id
end