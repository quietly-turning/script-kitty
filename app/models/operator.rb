class Operator < ActiveRecord::Base
    belongs_to :query
    has_many :conditions
end