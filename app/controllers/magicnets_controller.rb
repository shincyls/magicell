class MagicnetsController < ApplicationController
    include ApplicationHelper
    
    def dashboard
      respond_to :html, :js
    end

    def login
      respond_to :html, :js
    end

end