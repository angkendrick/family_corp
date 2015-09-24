class VouchersController < ApplicationController
  before_action :set_voucher, only: [:show, :edit, :update, :destroy]
  before_action :load_company, only: [:create, :index, :edit, :show, :new, :search]


  def index
    @vouchers = @company.vouchers.all.order(id: :asc).page(params[:page])
  end

  def show

    respond_to do |format|
      format.html
      format.pdf do
        pdf = VoucherPdf.new(@voucher, view_context)
        send_data pdf.render, filename:
            "voucher_#{@voucher.created_at.strftime('%m/%d/%Y')}.pdf",
            type: 'application/pdf',
            disposition:'inline' #open pdf instead of downloading
      end
    end

  end

  def new
    @voucher = Voucher.new
  end

  def edit
  end

  def create
    @voucher = @company.vouchers.new(voucher_params)

    respond_to do |format|
      if @voucher.save
        format.html { redirect_to company_vouchers_path, notice: 'Voucher was successfully created.' }
        format.json { render :show, status: :created, location: @voucher }
      else
        format.html { render :new }
        format.json { render json: @voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @voucher.update(voucher_params)
        format.html { redirect_to company_voucher_path, notice: 'Voucher was successfully updated.' }
        format.json { render :show, status: :ok, location: @voucher }
      else
        format.html { render :edit }
        format.json { render json: @voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @voucher.destroy
    respond_to do |format|
      format.html { redirect_to company_vouchers_path, notice: 'Voucher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    if params[:search].present?
      @vouchers = Voucher.search(params[:search], where: {company_id: params[:company_id]})
    else
      @vouchers = @company.vouchers.all
    end
  end

  # current homepage
  def redirect
    redirect_to '/companies/1/vouchers'
  end

  private

    def set_voucher
      @voucher = Voucher.find(params[:id])
    end

    def voucher_params
      params.require(:voucher).permit(:customer_id, :bank_id, :purchase_order, :confirmation_number, :description, :cheque_date, :cheque_number, :account_id, :department_id, :company_id, :user_id, :cheque_image, particulars_attributes: [:id, :voucher_id, :description, :amount, :_destroy])
    end

    def load_company
      @company = Company.find(params[:company_id])
    end
end
