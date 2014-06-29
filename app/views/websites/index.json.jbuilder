json.array!(@websites) do |website|
  json.extract! website, :id, :type, :url, :institution_id
  json.url website_url(website, format: :json)
end
