module ApplicationHelper

  # devise users
  def admin?
    user_signed_in? && current_user.admin?
  end

  # used in navbar
  def company_list
    @companies = Company.all.order(name: :asc)
  end

  def current_company
    url = request.original_url
    begin
      index = url.index('companies') + 10
      Company.find(url[index]).name
    rescue
      'Setup'
    end
  end

end
