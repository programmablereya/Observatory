class Tag < ActiveRecord::Base
	attr_readonly :category_id
	validates :name, :presence => true, :length => {:maximum => 20}
	has_permalink :name, :update => true
	belongs_to :category
	before_validation :format_description
	def to_param
		permalink
	end
	private
		def format_description
			self.description ||= ""
			self.descriptionHTML = RedCloth.new(description).to_html
		end
end
