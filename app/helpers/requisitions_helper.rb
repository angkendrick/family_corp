module RequisitionsHelper

  def approved
    @requisition.approved_by_id
  end

  def total(particular)
    if particular.amount
      number_with_delimiter('%.2f' % (particular.quantity * particular.amount))
    end
  end

  def grand_total(requisition)
    total = 0
    requisition.requisition_particulars.map do |particular|
      total += (particular.quantity * particular.amount)
    end
    number_with_delimiter('%.2f' % total)
  end

end
