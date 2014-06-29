json.array!(@levels) do |level|
  json.extract! level, :id, :description
  json.url level_url(level, format: :json)
end
