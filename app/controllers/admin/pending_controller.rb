class Admin::PendingController < ApplicationController



  def show
    @companies = Company.all
    @requisitions = Requisition.where(request_approval: 1).where(purchase_order_id: nil)
    @purchaseorders = PurchaseOrder.where(request_approval: 1).where(voucher_id: nil)
    render 'admin/show'
  end

end