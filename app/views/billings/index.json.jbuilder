json.array!(@billings) do |billing|
  json.extract! billing, :id, :user, :time_in, :time_out, :duration, :price
  json.url billing_url(billing, format: :json)
end
