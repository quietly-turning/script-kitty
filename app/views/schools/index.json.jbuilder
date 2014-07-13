json.array!(@schools) do |school|
  json.extract! school, :id, :name, :city, :state, :zip, :chief, :control_id, :locale_id
  json.url school_url(school, format: :json)
end
