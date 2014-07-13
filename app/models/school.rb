class School < ActiveRecord::Base
  belongs_to :control
  belongs_to :locale
  
  paginates_per 50
end
