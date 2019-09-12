class MagicnetsController < ApplicationController
    include ApplicationHelper
    # before_action :logged_in?, except: :login
    
    def dashboard
      respond_to :html, :js
      redirect_to login_path unless logged_in?
    end

    def login
      respond_to :html, :js
      redirect_to dashboard_url if logged_in?
    end

    # Dashboards for each role

    # Employee Pages
    def dashemployee
      respond_to :html, :js
      render template: "magicnets/view_emp/dashemployee"
    end

    # Load The Page
    def timesheetemployee
      respond_to :html, :js
      render template: "magicnets/view_emp/timesheetemployee"
    end

    def expenseemployee
      respond_to :html, :js
      render template: "magicnets/view_emp/expenseemployee"
    end



    # Finance Pages
    def dashfinance
      respond_to :html, :js
      render template: "magicnets/view_fin/dashfinance"
    end

    # HR Pages
    def dashhr
      respond_to :html, :js
      render template: "magicnets/view_hr/dashhr"
    end

    # PM Pages
    def dashpm
      respond_to :html, :js
      render template: "magicnets/view_pm/dashpm"
    end

    def approval
      respond_to :html, :js
      render template: "magicnets/view_pm/approval"
    end

    # IT Pages
    def dashit
      respond_to :html, :js
      render template: "magicnets/view_it/dashit"
    end

    def webrole
      respond_to :html, :js
      render template: "magicnets/view_it/webrole"
    end

    def account
      respond_to :html, :js
      render template: "magicnets/view_it/account"
    end

end