class User < ActiveRecord::Base
    has_many :queries



	#this method is called by devise to check for "active" state of the model
	def active_for_authentication?
		#remember to call the super
		#then put our own check to determine "active" state using 
		#our own "active" column
		super and self.active?
	end


	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
end