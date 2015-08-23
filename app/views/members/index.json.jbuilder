json.array!(@members) do |member|
  json.extract! member, :id, :name, :address, :phone, :barcode
  json.url member_url(member, format: :json)
end
