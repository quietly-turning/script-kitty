class School < ActiveRecord::Base
  has_many :websites
  belongs_to :locale
  
  paginates_per 50
end
