json.array!(@institutions) do |institution|
  json.extract! institution, :id, :name, :city, :state, :zip, :chief, :control_id, :level_id, :locale_id
  json.url institution_url(institution, format: :json)
end
