class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :company_list, :current_company

  def company_list
    @companies = Company.all
  end

  def current_company
    url = request.original_url
    company_id = url[url.index('companies') + 10]
    Company.find(company_id).name
  end

end
