module VouchersHelper

  include ActionView::Helpers::NumberHelper

  def sum_hash(hash)
    unless hash.nil?
      total = sprintf '%.2f', hash.inject(0) {|sum, hash| sum + hash[:amount]}
      number_with_delimiter(total, delimiter: :',')
    end
  end

  def sum_hash_words(hash)
    unless hash.nil?
      total = hash.inject(0) {|sum, hash| sum + hash[:amount]}
      total.humanize
    end
  end

  def generate_pdf_url
    url = request.original_url
    url += '.pdf'
  end

end
