class Tagging < ActiveRecord::Base
	# Maintain the object being tagged, which can be of any type.
	belongs_to :object, :polymorphic => true
	# Maintain the tag being attached to the object.
	belongs_to :tag, :inverse_of => :taggings
	# Prevent the tagging from changing objects or tags over its lifetime.
	# If the tag must be changed, remove and recreate the tagging.
	attr_readonly :object_id, :object_type, :tag_id
end
