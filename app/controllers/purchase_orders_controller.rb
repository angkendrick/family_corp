class PurchaseOrdersController < ApplicationController

  before_action :load_company, only: [:index, :show, :update]
  before_action :set_purchase_order, only: [:show, :update]

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

  def update
    if @purchase_order.update(purchase_order_params)
      redirect_to company_purchase_order_path(@company, @purchase_order), notice: 'Purchase Order was successfully updated.'
    else
      render :edit
    end
  end

  private

  def purchase_order_params
    params.require(:purchase_order).permit(:po_image1, :po_image2, :po_image3)
  end

  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def load_company
    @company = Company.find(params[:company_id])
  end

end
