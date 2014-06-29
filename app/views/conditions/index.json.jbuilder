json.array!(@conditions) do |condition|
  json.extract! condition, :id, :column, :parameter, :operator_id, :query_id, :complexOperator
  json.url condition_url(condition, format: :json)
end
