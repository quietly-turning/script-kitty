json.array!(@queries) do |query|
  json.extract! query, :id, :name, :dummy_id, :formatted_sql, :raw_sql, :html_table, :user_id
  json.url query_url(query, format: :json)
end
