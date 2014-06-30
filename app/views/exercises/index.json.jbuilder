json.array!(@exercises) do |exercise|
  json.extract! exercise, :id, :question
  json.url exercise_url(exercise, format: :json)
end
