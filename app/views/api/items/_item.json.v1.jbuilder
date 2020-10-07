json.cache! item do
  json.extract! item, :id, :name
  json.image url_for(item.image)
end
