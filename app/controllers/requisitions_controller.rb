class RequisitionsController < ApplicationController
  before_action :set_requisition, only: [:show, :edit, :update, :destroy]
  before_action :load_company, only: [:create, :index, :edit, :show, :new, :update, :search]


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

    respond_to do |format|
      if @requisition.save
        format.html { redirect_to company_requisitions_path, notice: 'Requisition was successfully created.' }
        format.json { render :show, status: :created, location: @requisition }
      else
        format.html { render :new }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @requisition.update(requisition_params)
        format.html { redirect_to company_requisition_path(@company, @requisition), notice: 'Requisition was successfully updated.' }
        format.json { render :show, status: :ok, location: @requisition }
      else
        format.html { render :edit }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @requisition.destroy
    respond_to do |format|
      format.html { redirect_to requisitions_url, notice: 'Requisition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_requisition
      @requisition = Requisition.find(params[:id])
    end

    def requisition_params
      params[:requisition].permit(:purchase_order, :confirmation_number, :customer_id, :user_id, :asset_id, :department_id, :company_id, :approved_by_id, :requisition_image, requisition_particulars_attributes: [:id, :quantity, :measurement_id, :requisition_id, :description, :amount, :_destroy])
    end

    def load_company
      @company = Company.find(params[:company_id])
    end
end
