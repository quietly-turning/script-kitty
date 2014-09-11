json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title, :objective, :body, :exercise_id
  json.url lesson_url(lesson, format: :json)
end
