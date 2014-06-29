json.array!(@operators) do |operator|
  json.extract! operator, :id, :name, :sql_value, :html_representation
  json.url operator_url(operator, format: :json)
end
