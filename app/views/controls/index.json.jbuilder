json.array!(@controls) do |control|
  json.extract! control, :id, :name, :description
  json.url control_url(control, format: :json)
end
