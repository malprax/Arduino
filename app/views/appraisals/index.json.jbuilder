json.array!(@appraisals) do |appraisal|
  json.extract! appraisal, :id, :address, :land_wide, :land_price, :building_wide, :building_price, :appraisal, :comment
  json.url appraisal_url(appraisal, format: :json)
end
