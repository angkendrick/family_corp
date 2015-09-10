class VoucherParticularsController < ApplicationController
  before_action :set_voucher_particular, only: [:show, :edit, :update, :destroy]

  # GET /voucher_particulars
  # GET /voucher_particulars.json
  def index
    @voucher_particulars = VoucherParticular.all
  end

  # GET /voucher_particulars/1
  # GET /voucher_particulars/1.json
  def show
  end

  # GET /voucher_particulars/new
  def new
    @voucher_particular = VoucherParticular.new
  end

  # GET /voucher_particulars/1/edit
  def edit
  end

  # POST /voucher_particulars
  # POST /voucher_particulars.json
  def create
    @voucher_particular = VoucherParticular.new(voucher_particular_params)

    respond_to do |format|
      if @voucher_particular.save
        format.html { redirect_to @voucher_particular, notice: 'Voucher particular was successfully created.' }
        format.json { render :show, status: :created, location: @voucher_particular }
      else
        format.html { render :new }
        format.json { render json: @voucher_particular.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /voucher_particulars/1
  # PATCH/PUT /voucher_particulars/1.json
  def update
    respond_to do |format|
      if @voucher_particular.update(voucher_particular_params)
        format.html { redirect_to @voucher_particular, notice: 'Voucher particular was successfully updated.' }
        format.json { render :show, status: :ok, location: @voucher_particular }
      else
        format.html { render :edit }
        format.json { render json: @voucher_particular.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voucher_particulars/1
  # DELETE /voucher_particulars/1.json
  def destroy
    @voucher_particular.destroy
    respond_to do |format|
      format.html { redirect_to voucher_particulars_url, notice: 'Voucher particular was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voucher_particular
      @voucher_particular = VoucherParticular.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voucher_particular_params
      params[:voucher_particular]
    end
end
