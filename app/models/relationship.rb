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

	# The source relationship is the one that this is a mirror of. Each
	# relationship is automatically created with a relationship mirroring
	# it. The mirror relationship is deleted with the source relationship,
	# and vice versa.
	belongs_to :source, :class_name => "Relationship", :dependent => :destroy, :inverse_of => :mirror
	has_one :mirror, :class_name => "Relationship", :foreign_key => "source_id", :dependent => :destroy, :inverse_of => :source

	# Class method to ease creation of two-way relationships.
	# Chara_a is chara_b's name_a. (Professor : teacher)
	# Chara_b is chara_b's name_b. (Jane Doe : student)
	# Use character objects here.
	def Relationship.connect(chara_a, name_a, chara_b, name_b)
		transaction do
			forward = new(:target => chara_b, :character => chara_a, :name => name_b)
			raise ActiveRecord::Rollback unless forward.save
			reverse = new(:target => chara_a, :character => chara_b, :name => name_a, :source => forward)
			raise ActiveRecord::Rollback unless reverse.save
		end
		return forward
	end
end
