class PurchaseOrdersController < ApplicationController

  before_action :load_company, only: [:index, :show]

  def index
    @purchase_orders = @company.purchase_orders.all.order(id: :asc).page(params[:page])
  end

  def show
  end

  private

  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def load_company
    @company = Company.find(params[:company_id])
  end

end
