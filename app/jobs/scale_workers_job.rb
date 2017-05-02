class ScaleWorkerJob < ActiveJob::Base

	include RabbitHelper
	include HerokuHelper

	def perform
		min = ENV["WORKERS_MIN"].to_1
		max = ENV["WORKERS_MAX"].to_1
		limit = ENV["WORKERS_JOB_LIMIT"].to_i
		increment = ENV["WORKERS_INCREMENT"]
		rmq_connect
		heroku_connect
		messages = rmq_count_messages
		consumers = rmq_count_consumers
		puts "Status: #{messages} queued messages for #{consumers} consumers"
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
