class StaticsController < ApplicationController

    def index
    end

    def login
        respond_to :html, :js
    end

    def show
        respond_to :html, :js
    end
    
end