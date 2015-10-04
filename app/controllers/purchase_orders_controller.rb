class PurchaseOrdersController < ApplicationController

  before_action :load_company, only: [:index, :show]
  before_action :set_purchase_order, only: [:show]

  def index
    @purchase_orders = @company.purchase_orders.all.order(created_at: :desc).page(params[:page])
  end

  def show

    respond_to do |format|
      format.html
      format.pdf do
        pdf = POPdf.new(@purchase_order, view_context)
        send_data pdf.render, filename:
                                "po_#{@purchase_order.created_at.strftime('%m/%d/%Y')}.pdf",
                  type: 'application/pdf',
                  disposition:'inline' #open pdf instead of downloading
      end
    end

  end

  private

  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def load_company
    @company = Company.find(params[:company_id])
  end

end
