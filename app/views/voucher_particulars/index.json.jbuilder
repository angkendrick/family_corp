json.array!(@voucher_particulars) do |voucher_particular|
  json.extract! voucher_particular, :id
  json.url voucher_particular_url(voucher_particular, format: :json)
end
