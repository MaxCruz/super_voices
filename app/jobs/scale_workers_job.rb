class ScaleWorkerJob < ActiveJob::Base

	include RabbitHelper
	include HerokuHelper

	def perform
		min = ENV["WORKERS_MIN"].to_i
		max = ENV["WORKERS_MAX"].to_i
		limit = ENV["WORKERS_JOB_LIMIT"].to_i
		increment = ENV["WORKERS_INCREMENT"].to_i
		rmq_connect
		heroku_connect
		messages = rmq_count_messages.to_i
		consumers = rmq_count_consumers.to_i
		puts "Current status: #{messages} queued messages for #{consumers} consumers"
		if messages >= limit && consumers < max
			puts "Increase one instance"
			n = consumers + increment
			heroku_scale("worker", n)
		else
			if consumers > min
				puts "Decrease one instance"
				n = consumers - increment
				heroku_scale("worker", n)
			end
		end
		rmq_disconnect
	end

end
