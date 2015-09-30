module VouchersHelper

  include ActionView::Helpers::NumberHelper

  def sum_hash(hash)

    total = hash.inject(0) {|sum, hash| sum + hash[:amount] unless hash[:amount].nil?}
    if total
      total = sprintf '%.2f', total
      number_with_delimiter(total, delimiter: :',')
    else
      0.00
    end
  end

  def sum_hash_words(hash)
    total = hash.inject(0) {|sum, hash| sum + hash[:amount]}
    decimal = (sprintf('%.2f', total.modulo(1))).to_s
    2.times { decimal[0] = '' }
    "#{total.humanize} & #{decimal}/100"
  end

  def generate_pdf_url
    url = request.original_url
    url += '.pdf'
  end

end
