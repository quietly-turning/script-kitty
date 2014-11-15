class Exercise < ActiveRecord::Base
    has_many :queries
	has_many :answers
	belongs_to :lesson

	def to_param
		"#{dummy_id}"
	end
end