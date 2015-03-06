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
		@unified_table_data = [["Lesson", "Correct Attempts", "Valid Attempts", "Invalid Attempts"]]
		@lessons.each do |lesson|
			@unified_table_data << [
				lesson.id.to_s,
				Lesson.joins(exercises: :queries).where(id: lesson.id, queries: {status: 2}).count,
				Lesson.joins(exercises: :queries).where(id: lesson.id, queries: {status: 1}).count,
				Lesson.joins(exercises: :queries).where(id: lesson.id, queries: {status: 0}).count
			]
		end


		@exercises = Exercise.order(:id).page params[:page]
		@columns = ["Invalid Attempts", "Valid Attempts", "Correct Attempts",  "Total Attempts" , "Unique Learners"]
		@table_data = {}

		@columns.each_with_index do |column, i|

			@table_data[column] = []
			@table_data[column] << ['Exercise ID', column]

			@exercises.each do |exercise|

				@table_data[column] << [
					# exercise id
					exercise.lesson_id.to_s +  "." + exercise.dummy_id.to_s,

					# total attempts column
					if i == 3
						exercise.queries.size

					# unique learners column
					elsif i == 4
						exercise.queries.select(:user_id).distinct.count

					# [invalid, valid, correct] attempts column
					elsif i >= 0 and i < 3
						exercise.queries.where(status: i).size
					end
				]
			end
		end

	end

	def lessons
		@lessons = Lesson.order(:id).page params[:page]
	end
end