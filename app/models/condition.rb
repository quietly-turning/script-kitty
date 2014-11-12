class Condition < ActiveRecord::Base
	belongs_to :operator
	belongs_to :query
end