module VouchersHelper

  include ActionView::Helpers::NumberHelper

  def sum_hash(hash)
    total = sprintf '%.2f', hash.inject(0) {|sum, hash| sum + hash[:amount]}
    number_with_delimiter(total, delimiter: :',')
  end

  def sum_hash_words(hash)
    total = hash.inject(0) {|sum, hash| sum + hash[:amount]}
    total.humanize
  end

end
