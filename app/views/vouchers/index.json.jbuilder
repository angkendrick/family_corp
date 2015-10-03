json.array!(@vouchers) do |voucher|
  json.extract! voucher, :id, :customer, :bank, :purchase_orders, :confirmation_number, :description
  json.url voucher_url(voucher, format: :json)
end
