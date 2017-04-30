class ScaleWorkerJob < ActiveJob::Base

	include RabbitHelper
	include HerokuHelper

	def perform
		min = 1
		max = 6
		limit = 10
		rmq_connect
		heroku_connect
		messages = rmq_count_messages
		consumers = rmq_count_consumers
		puts "Status: #{messages} queued messages for #{consumers} consumers"
		if messages >= limit && consumers < max
			puts "Increase one instance"
			n = consumers + 1
			heroku_scale("worker", n)
		else
			if consumers > min
				puts "Decrease one instance"
				n = consumers - 1
				heroku_scale("worker", n)
			end
		end
		rmq_disconnect
	end

end
