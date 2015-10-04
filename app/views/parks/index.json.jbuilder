json.array!(@parks) do |park|
  json.extract! park, :id, :number_parks, :billing_id
  json.url park_url(park, format: :json)
end
