class SessionsController < ApplicationController

    def new
    end

    def create
        user = Administrator.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to '/contests'
        else
            redirect_to '/login'
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to '/'
    end

end
