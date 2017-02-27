class AdministratorsController < ApplicationController
    before_action :set_administrator, only: [:show, :edit, :update]
    before_filter :authorize, only: [:show, :edit, :update]

    # GET /administrators
    def index
        if current_user
            redirect_to '/contests'
        end
    end

    # GET /administrators/1
    def show
    end

    # GET /administrators/new
    def new
        @administrator = Administrator.new
    end

    # GET /administrators/1/edit
    def edit
    end

    # POST /administrators
    def create
        @administrator = Administrator.new(administrator_params)
        respond_to do |format|
            if @administrator.save
                format.html { redirect_to '/', notice: 'Administrator was successfully created. Please login' }
            else
                format.html { render :new }
            end
        end
    end

    # PATCH/PUT /administrators/1
    def update
        respond_to do |format|
            if @administrator.update(administrator_params)
                format.html { redirect_to @administrator, notice: 'Administrator was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
        @administrator = Administrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_params
        params.require(:administrator).permit(:name, :last_name, :email, :password, :password_confirmation)
    end

end
