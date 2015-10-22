class RequisitionsController < ApplicationController
  before_action :set_requisition, only: [:show, :edit, :update, :destroy]
  before_action :load_company, only: [:create, :index, :edit, :show, :new, :update, :search, :destroy]
  before_action :prevent_edit, only: [:edit]

  def index
    @requisitions = @company.requisitions.all.order(approved_by_id: :desc, created_at: :desc).page(params[:page])
  end

  def show
  end

  def new
    @requisition = Requisition.new
  end

  def edit
  end

  def create
    create_requisition_number
    @requisition = @company.requisitions.new(requisition_params)
    @requisition.requisition_number = @new_number
    if @requisition.save
      redirect_to company_requisitions_path, notice: 'Requisition was successfully created.'
    else
      render :new
    end
  end

  def update
    @notice = ''

    if params['create_po']
      approve_requisition
    end

    if @requisition.update(requisition_params)
      @notice << 'Requisition was successfully updated.'
      redirect_to company_requisition_path(@company, @requisition), notice: @notice
    else
      render :edit
    end
  end

def destroy
  @requisition.destroy
  if @requisition.errors.nil?
    redirect_to company_requisitions_path(@company), notice: 'Requisition was successfully destroyed.'
  else
    flash[:error] = 'Unable to delete Requisition with attached Purchase Order'
    redirect_to company_requisitions_path(@company)
  end
end

private

  def set_requisition
    @requisition = Requisition.find(params[:id])
  end

  def requisition_params
    params[:requisition].permit(:purchase_order_number, :confirmation_number, :customer_id, :user_id, :asset_id, :department_id, :company_id, :approved_by_id, :requested_by_id, :purchase_order_id, :requisition_image, :request_approval, requisition_particulars_attributes: [:id, :quantity, :measurement_id, :requisition_id, :description, :amount, :_destroy])
  end

  def load_company
    @company = Company.find(params[:company_id])
  end

  def prevent_edit
    if @requisition.approved_by_id
      redirect_to company_requisitions_path(@company)
    end
  end

  def approve_requisition
    if current_user.role == 'approve'
      last_po = @company.purchase_orders.last
      if last_po.nil?
        new_po_number = 1
        new_confirmation_number = 1
      else
        last_po_number = last_po.purchase_order_number
        last_confirmation_number = last_po.confirmation_number
        last_po_number.nil? ? new_po_number = 1 : new_po_number = last_po_number + 1
        last_confirmation_number.nil? ? new_confirmation_number = 1 : new_confirmation_number = last_confirmation_number + 1
      end
      if po = PurchaseOrder.create(customer_id: @requisition.customer_id, user_id: current_user.id, asset_id: @requisition.asset_id, department_id: @requisition.department_id, company_id: @requisition.company_id, requisition_requested_by_id: @requisition.requested_by_id, requisition_number: @requisition.requisition_number, purchase_order_number: new_po_number, confirmation_number: new_confirmation_number)
        particulars = RequisitionParticular.where(requisition_id: @requisition.id)
        particulars.update_all(purchase_order_id: po.id)
        @requisition.update(purchase_order_id: po.id, purchase_order_number: po.purchase_order_number, confirmation_number: po.confirmation_number)
        @notice << 'Purchase Order was successfully created, '
      end
    else
      redirect_to company_requisition_path(@company, @requisition), error: 'Insufficient administrative privileges'
    end
  end

  def create_requisition_number
    requisition_number = @company.requisitions.last
    requisition_number.nil? ? @new_number = 1 : @new_number = requisition_number + 1
  end


end
