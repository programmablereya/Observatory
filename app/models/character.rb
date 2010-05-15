class Character < ActiveRecord::Base
	def to_param
		"#{id}-#{name.parameterize}"
	end
end
