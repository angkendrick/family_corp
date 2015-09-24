module VouchersHelper

  include ActionView::Helpers::NumberHelper

  def sum_hash(hash)
    total = hash.inject(0) {|sum, hash| sum + hash[:amount]}
    if total
      total = sprintf '%.2f', total
      number_with_delimiter(total, delimiter: :',')
    end
  end

  def sum_hash_words(hash)
    total = hash.inject(0) {|sum, hash| sum + hash[:amount]}
    total.humanize
  end

  def generate_pdf_url
    url = request.original_url
    url += '.pdf'
  end

end
