class Character < ActiveRecord::Base
	validates :name, :presence => true
	validates :textid, :presence => true, :uniqueness => true
	validate :check_is_parameter
	before_validation :format_description
	def to_param
		self.textid
	end
	private
		def check_is_parameter
			errors.add(:textid, "must be set to a valid URL parameter or left blank to use the character's name") unless textid == textid.parameterize
		end
		def format_description
			self.descriptionHTML = RedCloth.new(description).to_html
			if self.textid.nil? or self.textid == ""
				self.textid = name.parameterize 
			end
		end
end
