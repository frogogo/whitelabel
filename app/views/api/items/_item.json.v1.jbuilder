json.cache! item do
  json.extract! item, :id, :name
  json.image polymorphic_url(item.image) if item.image.present?
end
