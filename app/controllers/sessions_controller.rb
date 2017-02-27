class SessionsController < ApplicationController
    before_action :authorize, only: [:destroy]
    
    # GET /login
    def new
    end

    # POST /login
    def create
        user = Administrator.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to '/contests'
        else
            redirect_to '/login', notice: 'Wrong login. Please try again'
        end
    end

    # GET /logout
    def destroy
        session[:user_id] = nil
        redirect_to '/'
    end

end
