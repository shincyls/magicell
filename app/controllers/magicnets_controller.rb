class MagicnetsController < ApplicationController
    include ApplicationHelper

    before_action :logged_in?, except: :login
    
    def dashboard
      respond_to :html, :js
    end

    def login
      respond_to :html, :js
    end

    # Dashboards for each role

    def dashmanager
      respond_to :html, :js
    end

    def dashinfotech
      respond_to :html, :js
    end

    def dashemployee
      respond_to :html, :js
    end

    def dashfinance
      respond_to :html, :js
    end

    def dashboardhr
      respond_to :html, :js
    end

end