class Website < ActiveRecord::Base
  belongs_to :institution
  
  paginates_per 50
end
