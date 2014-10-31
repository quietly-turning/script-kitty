class Exercise < ActiveRecord::Base
    has_many :queries
	belongs_to :lesson

	def to_param
		"#{dummy_id}"
	end
end