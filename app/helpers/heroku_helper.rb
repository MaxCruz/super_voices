require 'heroku-api'

module HerokuHelper

	def heroku_connect
		@heroku = Heroku::API.new(:api_key => ENV["HEROKU_API_KEY"])
	end

	def heroku_scale(dyno, n)
		if n > 6
			return
		end
		@heroku.post_ps_scale("super-voices", dyno, n)
	end

end
