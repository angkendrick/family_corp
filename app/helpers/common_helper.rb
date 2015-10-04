module CommonHelper

  def generate_pdf_url
    url = request.original_url
    url += '.pdf'
  end

end