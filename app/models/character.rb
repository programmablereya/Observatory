class Character < ActiveRecord::Base
	before_validation :format_description
	def format_description
		self.descriptionHTML = RedCloth.new(description).to_html
	end
	def to_param
		"#{id}-#{name.parameterize}"
	end
end
