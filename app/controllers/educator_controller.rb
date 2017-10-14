class EducatorController < ApplicationController
	before_action :verify_is_educator

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
		@columns = ["Correct Attempts", "Valid Attempts", "Invalid Attempts",  "Total Attempts" , "Unique Learners"]
		@colors = {
			"Invalid Attempts"	=> "#f1656a",
			"Valid Attempts" 	=> "#60a1f4",
			"Correct Attempts" 	=> "#54be5e",
			"Total Attempts" 	=> "#ec814d",
			"Unique Learners" 	=> "#9881f5"
		}

		# --------------------------------------------------------------------------------
		@master_chart_data = [["Lesson", "Correct Attempts", "Valid Attempts", "Invalid Attempts"]]

		@lessons.each do |lesson|
			@master_chart_data << [
				lesson.id.to_s,
				Lesson.joins(exercises: :queries).where(id: lesson.id, queries: {status: 2}).count,
				Lesson.joins(exercises: :queries).where(id: lesson.id, queries: {status: 1}).count,
				Lesson.joins(exercises: :queries).where(id: lesson.id, queries: {status: 0}).count
			]
		end


		# --------------------------------------------------------------------------------
		@chart_data = {}
		@table_data = [["ID","Total Attempts", "Correct", "Valid", "Invalid", "Unique Learners"]]

		@exercises.each do |exercise|
			@table_data << [
				# exercise id
				exercise.lesson_id.to_s +  "." + exercise.dummy_id.to_s,
				# total
				exercise.queries.size,
				# correct
				exercise.queries.where(status: 2).size,
				# valid
				exercise.queries.where(status: 1).size,
				# invalid
				exercise.queries.where(status: 0).size,
				# unique learners
				exercise.queries.select(:user_id).distinct.count
			]
		end


		@columns.each do |column|

			@chart_data[column] = []
			@chart_data[column] << ['Exercise ID', column]

			@exercises.each do |exercise|

				@chart_data[column] << [
					# exercise id
					exercise.lesson_id.to_s +  "." + exercise.dummy_id.to_s,

					# total attempts column
					if column == "Total Attempts"
						exercise.queries.size

					# unique learners column
					elsif column == "Unique Learners"
						exercise.queries.select(:user_id).distinct.count

					# correct attempts column
					elsif column == "Correct Attempts"
						exercise.queries.where(status: 2).size

					# valid attempts column
					elsif column == "Valid Attempts"
						exercise.queries.where(status: 1).size

					# invalid attempts column
					elsif column == "Invalid Attempts"
						exercise.queries.where(status: 0).size

					end
				]
			end
		end

	end

	def lessons
		@lessons = Lesson.order(:id).page params[:page]
	end
end