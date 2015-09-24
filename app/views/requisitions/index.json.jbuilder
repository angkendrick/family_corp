json.array!(@requisitions) do |requisition|
  json.extract! requisition, :id
  json.url requisition_url(requisition, format: :json)
end
