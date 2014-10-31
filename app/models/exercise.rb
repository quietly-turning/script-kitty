class Exercise < ActiveRecord::Base
    has_many :queries
	belongs_to :lesson
end