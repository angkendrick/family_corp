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
    @notice = ''
    if params['create_voucher']
      create_voucher
    end

    if @purchase_order.update(purchase_order_params)
      @notice << 'Purchase Order was successfully updated.'
      redirect_to company_purchase_order_path(@company, @purchase_order), notice: @notice
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

  def create_voucher
    if current_user.role == 'approve'
      last_voucher = @company.vouchers.last
      if last_voucher.nil?
        new_voucher_number = 1
      else
        last_voucher_number = last_voucher.voucher_number
        last_voucher_number.nil? ? new_voucher_number = 1 : new_voucher_number = last_voucher_number + 1
      end
      if voucher = @company.vouchers.create(customer_id: @purchase_order.customer_id, purchase_order_number: @purchase_order.purchase_order_number, confirmation_number: @purchase_order.confirmation_number, department_id: @purchase_order.department_id, approved_by_id: current_user.id, voucher_number: new_voucher_number)
        @purchase_order.requisition_particulars.map do |particular|
          description = "#{particular.quantity} #{particular.measurement.name} #{particular.description} (#{particular.amount} ea.)"
          amount = (particular.quantity * particular.amount)
          voucher.particulars.create(description: description, amount: amount)
        end
        @purchase_order.update(voucher_id: voucher.id, voucher_number: new_voucher_number, approved_by_id: current_user.id )
        @notice << 'Voucher was successfully created, '
      end
    else
      redirect_to company_purchase_order_path(@company, @purchase_order), error: 'Insufficient administrative privileges'
    end
  end

end
