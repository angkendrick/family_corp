module PurchaseOrdersHelper

  def approved_po
    @purchase_order.approved_by_id
  end

end
