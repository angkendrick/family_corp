class VoucherPdf < Prawn::Document

  include VouchersHelper

  def initialize(voucher, view)
    super(:page_size => [600, 390], :font_size => 8)
    @voucher = voucher
    @view = view
    @size = 8
    heading
    payment
    particulars
    footer
  end

  def heading
    x = 440
    y = 350

    # Company
    bounding_box([x - 460, y + 2], :width => 400, :height => 20) do
      text_box @voucher.company.name, :valign => :center, :align => :left, :size => 18, :style => :bold
    end

    # Voucher heading
    bounding_box([x - 20, y], :width => 130, :height => 20) do
      transparent(1) {stroke_bounds}
      text_box 'VOUCHER', :valign => :center, :align => :center
    end

    # Voucher number and value
    bounding_box([x - 20, y - 20], :width => 130, :height => 15) do
      text_box 'NO.', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 8, y - 20], :width => 40, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box "#{@voucher.company.code}-#{@voucher.voucher_number}", :valign => :center, :align => :center, :size => 10
    end

    # AN and value
    bounding_box([x + 50, y - 20], :width => 100, :height => 15) do
      text_box 'AN.', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 68, y - 20], :width => 42, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box @voucher.approval_number.to_s, :valign => :center, :align => :center, :size => @size
    end

    # Voucher date and value
    bounding_box([x - 20, y - 35], :width => 130, :height => 15) do
      text_box 'DATE', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 8, y - 35], :width => 102, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box @voucher.created_at.strftime('%m/%d/%Y'), :valign => :center, :align => :center, :size => @size
    end

    # Purchase Order and value
    bounding_box([x - 20, y - 50], :width => 130, :height => 15) do
      text_box 'PO.', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 8, y - 50], :width => 40, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box "#{@voucher.company.code}-#{@voucher.purchase_order_number}", :valign => :center, :align => :center, :size => @size
    end

    # Confirmation Number and value
    bounding_box([x + 50, y - 50], :width => 100, :height => 15) do
      text_box 'CN.', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 68, y - 50], :width => 42, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box "#{@voucher.company.code}-#{@voucher.confirmation_number}", :valign => :center, :align => :center, :size => @size
    end
  end

  def payment
    x = -20
    y = 330

    # Paid to and value
    bounding_box([x, y], :width => 100, :height => 15) do
      text_box 'PAID TO', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 42, y], :width => 358, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box @voucher.customer.name, :valign => :center, :align => :center, :size => @size
    end

    # Bank and value
    bounding_box([x, y - 15], :width => 100, :height => 15) do
      text_box 'BANK', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 42, y - 15], :width => 100, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box "#{@voucher.bank.name if @voucher.bank}", :valign => :center, :align => :center, :size => @size
    end

    # Cheque and value
    bounding_box([x + 145, y - 15], :width => 100, :height => 15) do
      text_box 'CK #', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 180, y - 15], :width => 100, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box @voucher.cheque_number.to_s, :valign => :center, :align => :center, :size => @size
    end

    # Cheque date and value
    bounding_box([x + 282, y - 15], :width => 100, :height => 15) do
      text_box 'CK DATE', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 330, y - 15], :width => 70, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box "#{@voucher.cheque_date.strftime('%m/%d/%Y') if @voucher.cheque_date}", :valign => :center, :align => :center, :size => @size
    end

    # Account title and value
    bounding_box([x, y - 30], :width => 100, :height => 15) do
      text_box 'ACCOUNT TITLE', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 85, y - 30], :width => 120, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box "#{@voucher.account.title if @voucher.account}", :valign => :center, :align => :center, :size => @size
    end

    # Department name and value
    bounding_box([x + 210, y - 30], :width => 100, :height => 15) do
      text_box 'DEPARTMENT', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 280, y - 30], :width => 120, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box @voucher.department.name, :valign => :center, :align => :center, :size => @size
    end
  end

  def particulars
    x = -20
    y = 280
    list = ''
    list_amount = ''

    @voucher.particulars.map do |particular|
      list << particular.description
      list += "\n"
      list_amount << number_with_delimiter('%.2f' % particular.amount).to_s
      list_amount+= "\n"
    end

    # Particulars and Amount heading
    bounding_box([x, y], :width => 400, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box 'PARTICULARS', :valign => :center, :align => :center, :size => 10
    end
    bounding_box([x + 400, y], :width => 170, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box 'AMOUNT', :valign => :center, :align => :center, :size => 10
    end

    # Particulars detail value
    bounding_box([x + 2, y - 17], :width => 400, :height => 250) do
      text_box "RE: #{@voucher.description}", :valign => :top, :align => :left, :size => 10
    end

    # Particulars and Amount values
    bounding_box([x, y - 15], :width => 400, :height => 225) do
      transparent(1) {stroke_bounds}
    end
    bounding_box([x + 10, y - 30], :width => 400, :height => 225) do
      text_box "#{list}", :valign => :top, :align => :left, :size => @size
    end
    bounding_box([x + 400, y - 15], :width => 170, :height => 225) do
      transparent(1) {stroke_bounds}
    end
    bounding_box([x + 400, y - 30], :width => 130, :height => 225) do
      text_box list_amount, :valign => :top, :align => :right, :size => @size
    end

    # Total amount
    bounding_box([x + 400, y - 225], :width => 170, :height => 15) do
      transparent(1) {stroke_bounds}
    end
    bounding_box([x + 350, y - 225], :width => 130, :height => 15) do
      text_box 'TOTAL', :valign => :center, :size => 10
    end
    bounding_box([x + 400, y - 225], :width => 130, :height => 15) do
      text_box sum_hash(@voucher.particulars).to_s, :valign => :center, :align => :right, :size => 10
    end
  end

  def footer
    x = -20
    y = 40

    # Prepared by and value
    bounding_box([x, y], :width => 130, :height => 15) do
      text_box 'PREPARED BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 75, y], :width => 130, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box "#{@voucher.user.first_name if @voucher.user}", :valign => :center, :align => :center, :size => @size
    end

    # Checked by and value
    bounding_box([x, y - 15], :width => 130, :height => 15) do
      text_box 'CHECKED BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 75, y - 15], :width => 130, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box "#{@voucher.checked_by.first_name if @voucher.checked_by}", :valign => :center, :align => :center, :size => @size
    end

    # Approved by and value
    bounding_box([x, y - 30], :width => 130, :height => 15) do
      text_box 'APPROVED BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 75, y - 30], :width => 130, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box "#{@voucher.approved_by.first_name if @voucher.approved_by}", :valign => :center, :align => :center, :size => @size
    end

    # Pesos and value
    bounding_box([x + 250, y], :width => 130, :height => 30) do
      text_box 'PESOS', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 290, y], :width => 280, :height => 30) do
      transparent(1) {stroke_bounds}
      text_box "#{sum_hash_words(@voucher.particulars)} ONLY", :valign => :center, :align => :center, :size => 10
    end

    # Received by
    bounding_box([x + 250, y - 35], :width => 130, :height => 30) do
      text_box 'RECEIVED BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 320, y - 35], :width => 250, :height => 30) do
      transparent(1) {stroke_bounds}
    end
  end


end