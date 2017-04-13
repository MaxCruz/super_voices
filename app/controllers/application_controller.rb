class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
      if session[:user_id] 
          count = Administrator.count(session[:user_id])
          if count == 0
            session.delete(:message)
          else
            @current_user = Administrator.find(session[:user_id])
          end
      end
  end

  helper_method :current_user

  def authorize
      redirect_to "/login" unless current_user
  end

end
