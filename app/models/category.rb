class Category < ActiveRecord::Base
	# A category must have a name of no more than 20 characters.
	# Blank categories will not be accepted.
	validates :name, :presence => true, :length => {:maximum => 20}

	# Create a permalink from the category name. Update it when
	# the category name changes.
	has_permalink :name, :update => true
	# Use the permalink in place of the id for URLs.
	def to_param
		permalink
	end
	# Protect the permalink from being modified by user edits.
	attr_protected :permalink

	# Track tags in this category.
	has_many :tags, :dependent => :destroy, :inverse_of => :category

	# Sort alphabetically by default.
	default_scope :order => "name ASC"

	# Keep the HTML-formatted description up to date if the Textile
	# description has changed when saving.
	before_validation :format_description
	private
		def format_description
			# Don't waste cycles if there's no change.
			return unless description_changed?
			self.descriptionHTML = description.blank? ? "" : RedCloth.new(description).to_html
		end
end
