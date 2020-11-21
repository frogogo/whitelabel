json.cache! item do
  json.extract! item, :id, :name
  if item.image.present? do
    json.image_url item.image.url
    json.image_medium_url item.image.medium.url
  end
end
