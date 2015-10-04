class POPdf < Prawn::Document

   include VouchersHelper
   include RequisitionsHelper

  def initialize(object, view)
    super(:page_size => [600, 390], :font_size => 8)
    @po = object
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
      text_box @po.company.name, :valign => :center, :align => :left, :size => 18, :style => :bold
    end

    # PO heading
    bounding_box([x, y], :width => 110, :height => 35) do
      transparent(1) {stroke_bounds}
      text_box 'PURCHASE ORDER', :valign => :center, :align => :center
    end

    # PO date and value
    bounding_box([x, y - 35], :width => 100, :height => 15) do
      text_box 'DATE', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 28, y - 35], :width => 82, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box @po.created_at.strftime('%m/%d/%Y'), :valign => :center, :align => :center, :size => @size
    end

    # Purchase Order and value
    bounding_box([x, y - 50], :width => 100, :height => 15) do
      text_box 'NO.', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 28, y - 50], :width => 30, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box '', :valign => :center, :align => :center, :size => @size
    end

    # Confirmation Number and value
    bounding_box([x + 60, y - 50], :width => 100, :height => 15) do
      text_box 'CN.', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 80, y - 50], :width => 30, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box '', :valign => :center, :align => :center, :size => @size
    end
  end

  def payment
    x = -20
    y = 330

    # Paid to and value
    bounding_box([x, y], :width => 100, :height => 15) do
      text_box 'TO', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 50, y], :width => 350, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box @po.customer.name, :valign => :center, :align => :center, :size => @size
    end

    # Deliver To and value
    bounding_box([x, y - 15], :width => 100, :height => 15) do
      text_box 'DELIVER', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 50, y - 15], :width => 350, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box '', :valign => :center, :align => :center, :size => @size
    end

    # RN and value
    bounding_box([x, y - 30], :width => 100, :height => 15) do
      text_box 'RN', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 50, y - 30], :width => 45, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box '', :valign => :center, :align => :center, :size => @size
    end

    # Asset and value
    bounding_box([x + 100, y - 30], :width => 100, :height => 15) do
      text_box 'FOR', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 125, y - 30], :width => 80, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box @po.asset.name, :valign => :center, :align => :center, :size => @size
    end

    # Requested by name and value
    bounding_box([x + 210, y - 30], :width => 100, :height => 15) do
      text_box 'REQUESTED BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 295, y - 30], :width => 105, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box @po.requested_by.first_name, :valign => :center, :align => :center, :size => @size
    end
  end

  def particulars
    x = -20
    y = 280
    list = ''
    list_amount = ''

    @po.requisition_particulars.map do |particular|
      list << "#{particular.quantity.to_s} "
      list << "#{particular.measurement.name} "
      list << "#{particular.description} "
      list << "#{number_with_delimiter('%.2f' % particular.amount)} ea."
      list += "\n"
      list_amount << total(particular).to_s
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
      text_box '', :valign => :top, :align => :left, :size => 10
    end

    # Particulars and Amount values
    bounding_box([x, y - 15], :width => 400, :height => 225) do
      transparent(1) {stroke_bounds}
    end
    bounding_box([x + 10, y - 30], :width => 400, :height => 225) do
      text_box list, :valign => :top, :align => :left, :size => @size
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
      text_box grand_total(@po).to_s, :valign => :center, :align => :right, :size => 10
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
      text_box '', :valign => :center, :align => :center, :size => @size
    end

    # Pickup by and value
    bounding_box([x, y - 15], :width => 130, :height => 15) do
      text_box 'PICK-UP BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 75, y - 15], :width => 130, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box '', :valign => :center, :align => :center, :size => @size
    end

    # Approved by and value
    bounding_box([x, y - 30], :width => 130, :height => 15) do
      text_box 'APPROVED BY', :valign => :center, :align => :left, :size => 10
    end
    bounding_box([x + 75, y - 30], :width => 130, :height => 15) do
      transparent(1) {stroke_bounds}
      text_box '', :valign => :center, :align => :center, :size => @size
    end

  end


end