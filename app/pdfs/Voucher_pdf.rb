class VoucherPdf < Prawn::Document

  include VouchersHelper

  def initialize(voucher, view)
    super(:page_size => [600, 400], :font_size => 8)
    @voucher = voucher
    @view = view
    heading
    payment
    particulars
    footer
  end

  def heading
    x = 440
    y = 350

    # Company
    bounding_box([x - 460, y + 5], :width => 110, :height => 20) do
      text @voucher.company.name, :valign => :center, :align => :left, :size => 14
    end

    # Voucher heading
    bounding_box([x, y], :width => 110, :height => 20) do
      transparent(1) {stroke_bounds}
      text 'VOUCHER', :valign => :center, :align => :center
    end

    # Voucher number and value
    bounding_box([x, y - 20], :width => 100, :height => 15) do
      text 'NO.', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 28, y - 20], :width => 82, :height => 15) do
      transparent(1) {stroke_bounds}
      text '1', :valign => :center, :align => :center, :size => 10
    end

    # Voucher date and value
    bounding_box([x, y - 35], :width => 100, :height => 15) do
      text 'DATE', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 28, y - 35], :width => 82, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.created_at.strftime('%m/%d/%Y'), :valign => :center, :align => :center, :size => 10
    end

    # Purchase Order and value
    bounding_box([x, y - 50], :width => 100, :height => 15) do
      text 'PO.', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 28, y - 50], :width => 30, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.purchase_order.to_s, :valign => :center, :align => :center, :size => 10
    end

    # Confirmation Number and value
    bounding_box([x + 60, y - 50], :width => 100, :height => 15) do
      text 'CN.', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 80, y - 50], :width => 30, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.confirmation_number.to_s, :valign => :center, :align => :center, :size => 10
    end
  end

  def payment
    x = -20
    y = 330

    # Paid to and value
    bounding_box([x, y], :width => 100, :height => 15) do
      text 'PAID TO', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 42, y], :width => 358, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.customer.name, :valign => :center, :align => :center, :size => 10
    end

    # Bank and value
    bounding_box([x, y - 15], :width => 100, :height => 15) do
      text 'BANK', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 42, y - 15], :width => 100, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.bank.name, :valign => :center, :align => :center, :size => 10
    end

    # Cheque and value
    bounding_box([x + 145, y - 15], :width => 100, :height => 15) do
      text 'CK #', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 180, y - 15], :width => 100, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.cheque_number.to_s, :valign => :center, :align => :center, :size => 10
    end

    # Cheque date and value
    bounding_box([x + 282, y - 15], :width => 100, :height => 15) do
      text 'CK DATE', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 330, y - 15], :width => 70, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.cheque_date.strftime('%m/%d/%Y'), :valign => :center, :align => :center, :size => 10
    end

    # Account title and value
    bounding_box([x, y - 30], :width => 100, :height => 15) do
      text 'ACCOUNT TITLE', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 85, y - 30], :width => 120, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.account.title, :valign => :center, :align => :center, :size => 10
    end

    # Department name and value
    bounding_box([x + 210, y - 30], :width => 100, :height => 15) do
      text 'DEPARTMENT', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 280, y - 30], :width => 120, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.account.title, :valign => :center, :align => :center, :size => 10
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
      list_amount << number_with_delimiter(particular.amount).to_s
      list_amount+= "\n"
    end

    # Particulars and Amount heading
    bounding_box([x, y], :width => 400, :height => 15) do
      transparent(1) {stroke_bounds}
      text 'PARTICULARS', :valign => :center, :align => :center, :size => 10
    end
    bounding_box([x + 400, y], :width => 170, :height => 15) do
      transparent(1) {stroke_bounds}
      text 'AMOUNT', :valign => :center, :align => :center, :size => 10
    end

    # Particulars detail value
    bounding_box([x + 2, y - 17], :width => 400, :height => 250) do
      text "RE: #{@voucher.description}", :valign => :top, :align => :left, :size => 10
    end

    # Particulars and Amount values
    bounding_box([x, y - 15], :width => 400, :height => 225) do
      transparent(1) {stroke_bounds}
      text list, :valign => :center, :align => :center, :size => 10
    end
    bounding_box([x + 400, y - 15], :width => 170, :height => 225) do
      transparent(1) {stroke_bounds}
    end
    bounding_box([x + 400, y - 15], :width => 130, :height => 225) do
      text list_amount, :valign => :center, :align => :right, :size => 10
    end

    # Total amount
    bounding_box([x + 400, y - 225], :width => 170, :height => 15) do
      transparent(1) {stroke_bounds}
    end
    bounding_box([x + 350, y - 225], :width => 130, :height => 15) do
      text 'TOTAL', :valign => :center, :size => 10
    end
    bounding_box([x + 400, y - 225], :width => 130, :height => 15) do
      text sum_hash(@voucher.particulars).to_s, :valign => :center, :align => :right, :size => 10
    end
  end

  def footer
    x = -20
    y = 40

    # Prepared by and value
    bounding_box([x, y], :width => 130, :height => 15) do
      text 'PREPARED BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 75, y], :width => 130, :height => 15) do
      transparent(1) {stroke_bounds}
      text @voucher.user.first_name, :valign => :center, :align => :center, :size => 10
    end

    # Prepared by and value
    bounding_box([x, y - 15], :width => 130, :height => 15) do
      text 'APPROVED BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 75, y - 15], :width => 130, :height => 15) do
      transparent(1) {stroke_bounds}
      text '', :valign => :center, :align => :center, :size => 10
    end

    # Pesos and value
    bounding_box([x + 250, y], :width => 130, :height => 30) do
      text 'PESOS', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 290, y], :width => 280, :height => 30) do
      transparent(1) {stroke_bounds}
      text sum_hash_words(@voucher.particulars), :valign => :center, :align => :center, :size => 10
    end

    # Received by
    bounding_box([x + 250, y - 35], :width => 130, :height => 30) do
      text 'RECEIVED BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 320, y - 35], :width => 250, :height => 30) do
      transparent(1) {stroke_bounds}
    end
  end


end