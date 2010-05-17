class Relationship < ActiveRecord::Base
	# A relationship must have a name no longer than 20 characters.
	validates :name, :presence => true, :length => {:maximum => 20}

	# Use the name of the relationship to generate a permalink,
	# updating it when the name changes. Permalinks should only
	# be unique for the character from which they are attached.
	has_permalink :name, :update => true, :scope => :character_id
	# Use the permalink to generate paths to this relationship.
	def to_param
		permalink
	end
	# Protect the permalink from user edits.
	attr_protected :permalink

	# The character is the source of the relationship.
	belongs_to :character, :inverse_of => :relationships
	# The target is the character related to the source by the name
	# of the relationship. For example, given :character => a,
	# :target => b, :name => leader, b is the leader of a.
	belongs_to :target, :foreign_key => "to_id", :class_name => "Character", :inverse_of => :reverse_relationships
	# Neither the character nor the target should change. If this
	# needs to be the case, the relationship can be recreated.
	attr_readonly :character_id, :to_id
	# Both sides must be present or it isn't much of a relationship.
	validates :character, :presence => true, :associated => true
	validates :target, :presence => true, :associated => true

	# The source relationship is the one that this is a mirror of. Each
	# relationship is automatically created with a relationship mirroring
	# it. The mirror relationship is deleted with the source relationship,
	# and vice versa.
	belongs_to :source, :class_name => "Relationship", :dependent => :destroy, :inverse_of => :mirror
	has_one :mirror, :class_name => "Relationship", :foreign_key => "source_id", :dependent => :destroy, :inverse_of => :source

	# Check that the mirror is valid, unless this is the mirror.
	validate :mirror_valid
	def mirror_valid
		return unless source.nil?
		if mirror.nil?
			errors[:base] << "Reverse link can't be blank"
		elsif !mirror.valid?
			mirror.errors.full_messages.each do |m|
				errors[:base] << "Reverse " + m
			end
		end
	end

	# Instance method to easily find or create the reverse
	# relationship from this one.
	def reverse
		if source
			source
		elsif mirror
			mirror
		else
			Relationship.new(:target => character, :character => target, :source => self, :name => name)
		end
	end

	# Attribute methods using the above to quickly assign the name
	# of the reverse relation. Allows reverse_name to be specified
	# in the create or update.
	def reverse_name
		reverse.name
	end
	def reverse_name=(value)
		reverse.name = value
	end
end
