class VouchersController < ApplicationController
  before_action :set_voucher, only: [:show, :edit, :update, :destroy]
  before_action :load_company, only: [:create, :index, :edit, :show, :new, :search, :update]


  def index
    @vouchers = @company.vouchers.all.order(id: :desc).page(params[:page])
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
    if check_approval_number(params)
      @voucher = @company.vouchers.new(voucher_params)
        if @voucher.save
          redirect_to company_vouchers_path, notice: 'Voucher was successfully created.'
        else
          render :new
        end
    else
      @voucher = @company.vouchers.new(voucher_params)
      flash[:error] = 'Please include an AN before adding payment information'
      render :new
    end
  end

  def update
    if check_approval_number(params)
      if @voucher.update(voucher_params)
        redirect_to company_voucher_path, notice: 'Voucher was successfully updated.'
      else
        render :edit
      end
    else
      flash[:error] = 'Please include an AN before adding payment information'
      redirect_to edit_company_voucher_path(@company, @voucher)
      #render :edit
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
      params.require(:voucher).permit(:customer_id, :bank_id, :purchase_orders, :confirmation_number, :description, :cheque_date, :cheque_number, :account_id, :department_id, :company_id, :user_id, :approval_number, :checked_by_id, :approved_by_id, :cheque_image, particulars_attributes: [:id, :voucher_id, :description, :amount, :_destroy])
    end

    def load_company
      @company = Company.find(params[:company_id])
    end

    def check_approval_number(params)
      if (params[:voucher][:approval_number].empty?) && (!params[:voucher][:cheque_number].empty? || !params[:voucher][:bank_id].empty? || !params[:voucher]['cheque_date(1i)'].empty? || !params[:voucher]['cheque_date(2i)'].empty? || !params[:voucher]['cheque_date(3i)'].empty?)
        false # approval_number empty and has payment information
      else
        true
      # elsif !params[:voucher][:approval_number].empty?
      #   true # approval_number has information
      # elsif params[:voucher][:approval_number].empty?
      #   true # approval_number is empty
      end
    end

end
