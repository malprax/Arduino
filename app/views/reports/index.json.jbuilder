json.array!(@reports) do |report|
  json.extract! report, :id, :date, :member, :time_in, :time_out, :duration, :price
  json.url report_url(report, format: :json)
end
