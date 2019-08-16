class MagicnetsController < ApplicationController
    include ApplicationHelper

    before_action :logged_in?, except: :login
    
    def dashboard
      respond_to :html, :js
    end

    def login
      respond_to :html, :js
    end


end