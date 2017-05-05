class SessionsController < ApplicationController
	before_action :authorize, only: [:destroy]

	# GET /login
	def new
	end

	# POST /login
	def create
		user = Administrator.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id.to_s
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

	def queue
		respond_to do |format|
			msg = { :name => "worker", :quantity => 1000 }
			format.json  { render :json => msg }
		end
	end

end
