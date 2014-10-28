json.array!(@queries) do |query|
  json.extract! query, :id, :dummy_id, :raw_sql, :html_table, :user_id
  json.url query_url(query, format: :json)
end
