class PinnedEntity < ActiveRecord::Base
  attr_accessible :entity_id, :entity_type, :collection_id, :order
  belongs_to :collection
  belongs_to :entity, :polymorphic => true, :foreign_key => :entity_id
end
