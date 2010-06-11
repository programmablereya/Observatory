class Tag < ActiveRecord::Base
	# Tags must have a name that is not blank and not longer than
	# 20 characters.
	validates :name, :presence => true, :length => {:maximum => 20}

	# Use the name to generate a permalink in the permalink field.
	has_permalink :name, :update => true
	# Use the permalink to generate search-/user-friendly URLs.
	def to_param
		permalink
	end
	# Protect the permalink from being edited by the user.
	attr_protected :permalink

	# All tags must have a category.
	belongs_to :category, :inverse_of => :tags
	validates :category_id, :presence => true
	# Prevent the category from being changed by form tampering after
	# the tag has been created.
	attr_protected :category_id

	# Track objects that have been tagged with this tag.
	# Untag them if this tag is destroyed.
	has_many :taggings, :dependent => :destroy, :inverse_of => :tag
	has_many :tagged_characters, :through => :taggings, :source => :object, :source_type => "Character"
	has_many :tagged_tags, :through => :taggings, :source => :object, :source_type => "Tag"
	# Track tags that this tag has been tagged with.
	# Untag them if this tag is destroyed.
	has_many :r_taggings, :dependent => :destroy, :class_name => "Tagging", :as => :object
	has_many :tags, :through => :r_taggings
	
	# Sort by name if nothing else given.
	default_scope :order => 'name ASC'

	# Keep the HTML-formatted description up to date if the Textile
	# description was changed.
	before_validation :format_description
	private
		def format_description
			# Don't bother with RedCloth if the description is
			# unchanged since the last time it was saved.
			return unless description_changed?
			self.descriptionHTML = description.blank? ? "" : RedCloth.new(description).to_html
		end
end
