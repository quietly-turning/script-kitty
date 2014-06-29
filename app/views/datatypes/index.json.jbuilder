json.array!(@datatypes) do |datatype|
  json.extract! datatype, :id, :name
  json.url datatype_url(datatype, format: :json)
end
