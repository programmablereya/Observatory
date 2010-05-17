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

	# All tags must have a category.
	belongs_to :category
	validates :category_id, :presence => true
	# Prevent the category from being changed by form tampering after
	# the tag has been created.
	attr_protected :category_id

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
