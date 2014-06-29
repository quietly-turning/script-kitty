json.array!(@locales) do |locale|
  json.extract! locale, :id, :name, :description
  json.url locale_url(locale, format: :json)
end
