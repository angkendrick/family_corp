class RequisitionsController < ApplicationController
  before_action :set_requisition, only: [:show, :edit, :update, :destroy]
  before_action :load_company, only: [:create, :index, :edit, :show, :new, :update, :search, :destroy]


  def index
    @requisitions = @company.requisitions.all.order(id: :asc).page(params[:page])
  end

  def show
  end

  def new
    @requisition = Requisition.new
  end

  def edit
  end

  def create
    @requisition = @company.requisitions.new(requisition_params)
    if @requisition.save
      redirect_to company_requisitions_path, notice: 'Requisition was successfully created.'
    else
      render :new
    end
  end

  def update
    @notice = ''
    if params['create_po']
      if po = PurchaseOrder.create(customer_id: @requisition.customer_id, user_id: current_user.id, asset_id: @requisition.asset_id, department_id: @requisition.department_id, company_id: @requisition.company_id, requisition_requested_by_id: @requisition.requested_by_id)
        particulars = RequisitionParticular.where(requisition_id: @requisition.id)
        particulars.update_all(purchase_order_id: po.id)
        @notice << 'Purchase Order was successfully created, '
      end
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
    respond_to do |format|
      format.html { redirect_to company_requisitions_path(@company), notice: 'Requisition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_requisition
      @requisition = Requisition.find(params[:id])
    end

    def requisition_params
      params[:requisition].permit(:purchase_orders, :confirmation_number, :customer_id, :user_id, :asset_id, :department_id, :company_id, :approved_by_id, :requested_by_id, :requisition_image, requisition_particulars_attributes: [:id, :quantity, :measurement_id, :requisition_id, :description, :amount, :_destroy])
    end

    def load_company
      @company = Company.find(params[:company_id])
    end
end
