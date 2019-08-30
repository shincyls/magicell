class RegistersController < ApplicationController
  include ApplicationHelper
  
  before_action :set_register, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    respond_to :html, :js
    @registers = Register.all.order("created_at desc")
    #@registers = @registers.paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html
      format.csv { send_data @registers.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def list
    respond_to :html, :js
    @data = params[:button]
    
    if @data == "3"
      @registers = Register.all
    else
      @registers = Register.all.where(category: @data)
    end

    if params[:check]
      @registers = @registers.where(attendance: false)
    end

    if params[:uncheck]
      @registers = @registers.where(attendance: true)
    end

    if params[:hide_sort]
      @registers = @registers.where(status: 0)
    end

    if params[:ticket_sort]
      @registers = @registers.order("ticket_number desc NULLS LAST")
    end

    @registers = @registers.order("created_at desc")

  end

  def show
    @register = Register.find(params[:id])
  end

  def attendance
    respond_to :html, :js
    @register = Register.find(params[:id])
    if @register.attendance == true
      @register.attendance = false
    else
      @register.attendance = true
    end
    @register.save
  end

  def printa
    respond_to :html, :js
    @register = Register.find(params[:id])
    if @register.ticket_number.nil?
      @register.convert_ticket_number
    end
    @register.save
  end

  def printupdate
    respond_to :html, :js
    @register = Register.find(params[:id])    
    @register.status = 1
    @register.save
  end

  def reset
    @registers = Register.all
    @registers.each do |r|
      r.status = 0
      r.ticket_number = nil
      r.attendance = false
      r.save
    end

    @content = WebappContent.find_by(name: "running_number")
    @content.value = 1
    @content.save
    
    respond_to do |format|
      format.html { redirect_to registers_path, notice: "Ticket Number and Printing Status has been successfully reset." }
    end

  end

  # GET /registers/new
  def new
    @register = Register.new
  end

  # GET /registers/1/edit
  def edit
  end

  # POST /registers
  def create
    respond_to do |format|
      @register = Register.new(register_params)

      if @register.save
        format.html { redirect_to new_register_path, notice: "#{@register.full_name} from #{@register.info_1} with table #{@register.info_2} has been successfully registered." }
      else
        format.html { render :new }
        format.js { flash.now[:warning] = @register.errors.full_messages }
      end
    end
  end

  # PATCH/PUT /registers/1
  def update
    respond_to do |format|
      if @register.update(register_params)
        format.html { redirect_to @register, notice: 'Register was successfully updated.' }
      else
        format.html { render :edit }
        format.js { flash.now[:warning] = @register.errors.full_messages }
      end
    end
  end

  # DELETE /registers/1
  # DELETE /registers/1.json
  def destroy
    @register.destroy
    respond_to do |format|
      format.html { redirect_to registers_url, notice: 'Register was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_register
      @register = Register.find(params[:id])
    end

    def require_login
      unless logged_in?
        flash[:alert] = "You must be logged in to access this section"
        redirect_to root_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def register_params
      params.require(:register).permit(:full_name, :first_name, :last_name, :phone_number, :phone_number_2, :identity_number, :category, :drawing_chance, :info_1, :info_2, :info_3, :info_4, :info_5, :attendance)
    end
end
