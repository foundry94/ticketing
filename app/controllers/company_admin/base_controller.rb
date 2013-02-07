module CompanyAdmin
  class BaseController < ApplicationController
    layout "company_admin"

    before_filter :authenticate_user!

  end  
end
