class Character < ActiveRecord::Base
	# Character must have a name.
	validates :name, :presence => true

	# Create a permalink in the permalink attribute based on the name.
	# Update it when the name is changed.
	has_permalink :name, :update => true
	# Use the permalink instead of the id when creating paths.
	def to_param
		permalink
	end
	# Protect the permalink from being updated by user edits.
	attr_protected :permalink

	# Character may be derivative of some other character (the parent).
	belongs_to :parent, :class_name => "Character"
	# Prevent the parent character from being changed after it's created.
        attr_protected :parent_id
	# Track all alternates (characters listing this one as a parent)
	# and cascade-destroy them when this character is destroyed.
	has_many :alternates, :class_name => "Character", :foreign_key => "parent_id", :dependent => :destroy

	# Keep track of connections to this character in either direction.
	# Destroy them if this character is destroyed.
	has_many :relationships, :dependent => :destroy, :inverse_of => :character
	has_many :reverse_relationships, :dependent => :destroy, :foreign_key => "to_id", :class_name => "Relationship", :inverse_of => :target

	# Sort by name if nothing else given.
	default_scope :order => 'name ASC'

	# Before validating for a save, translate the Textile in the
	# description to HTML for cheaper display later on. It costs
	# more room in the database, but it's cheaper processing-wise.
	before_validation :format_description
	private
		# Uses RedCloth to translate the description from Textile
		# into HTML.
		def format_description
			# Don't rewrite the description HTML if the description
			# hasn't changed.
			return unless description_changed?
			self.descriptionHTML = description.blank? ? "" : RedCloth.new(description).to_html
		end
end
