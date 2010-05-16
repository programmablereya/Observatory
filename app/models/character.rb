class Character < ActiveRecord::Base
	has_permalink :name, :update => true
        attr_readonly :parent_id
	validates :name, :presence => true
	before_validation :format_description
	has_many :alternates, :class_name => "Character", :foreign_key => "parent_id", :dependent => :destroy
	belongs_to :parent, :class_name => "Character"
	def to_param
		permalink
	end
	private
		def format_description
			self.description ||= ""
			self.descriptionHTML = RedCloth.new(description).to_html
		end
end
