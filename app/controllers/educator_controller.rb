class EducatorController < ApplicationController
	before_filter :verify_is_educator

	def index
		# don't bother showing educators the flash-notification about having logged in
		flash.discard(:notice)
	end

	def learners
		@users = User.order(:id).page params[:page]
	end

	def exercises
		@lessons = Lesson.all
		@exercises = Exercise.order(:id).page params[:page]

		@columns = 	[
						{type: "number", name:  "Total Attempts" },
						{type: "number", name:  "Correct Attempts" },
			 			{type: "number", name:  "Valid Attempts" },
						{type: "number", name:  "Invalid Attempts" },
						{type: "number", name:  "Unique Learners" },
					]

	end

	def lessons
		@lessons = Lesson.order(:id).page params[:page]
	end
end