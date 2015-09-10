module VouchersHelper

  def sum_hash(hash)
    sprintf '%.2f', hash.inject(0) {|sum, hash| sum + hash[:amount]}
  end

end
