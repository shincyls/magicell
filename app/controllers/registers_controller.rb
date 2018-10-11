class RegistersController < ApplicationController
  before_action :set_register, only: [:show, :edit, :update, :destroy]


  def index
    respond_to :html, :js
    @registers = Register.all.order("created_at asc")
    @registers = @registers.paginate(:page => params[:page], :per_page => 20)
  end

  def show
  end

  def printa
    respond_to :html, :js
    @register = Register.find(params[:id])
  end
  
  def printb
    respond_to :html, :js
    @register = Register.find(params[:id])
  end
  
  def printc
    respond_to :html, :js
    @register = Register.find(params[:id])
  end

  def printd
    respond_to :html, :js
    @register = Register.find(params[:id])
  end

  def printe
    respond_to :html, :js
    @register = Register.find(params[:id])
  end

  def list
    respond_to :html, :js
    @registers = Array.new
    if params[:query].empty? || params[:query] == "all"
      @registers = Register.all.order("created_at asc")
    else
      @registers = Register.search_registers(params[:query])
    end
 
    @registers = @registers.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /registers/new
  def new
    @register = Register.new
  end

  # GET /registers/1/edit
  def edit
  end

  # POST /registers
  # POST /registers.json
  def create
    @register = Register.new(register_params)

    respond_to do |format|
      if @register.save
        format.html { redirect_to @register, notice: 'Register was successfully created.' }
        format.json { render :show, status: :created, location: @register }
      else
        format.html { render :new }
        format.json { render json: @register.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registers/1
  # PATCH/PUT /registers/1.json
  def update
    respond_to do |format|
      if @register.update(register_params)
        format.html { redirect_to @register, notice: 'Register was successfully updated.' }
        format.json { render :show, status: :ok, location: @register }
      else
        format.html { render :edit }
        format.json { render json: @register.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registers/1
  # DELETE /registers/1.json
  def destroy
    @register.destroy
    respond_to do |format|
      format.html { redirect_to registers_url, notice: 'Register was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_register
      @register = Register.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def register_params
      params.require(:register).permit(:first_name, :last_name, :phone_number, :email, :field_1, :field_2, :field_3)
    end
end
