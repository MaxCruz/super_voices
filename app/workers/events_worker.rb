require 'sneakers'

class EventsWorker

	include Sneakers::Worker

	from_queue ENV['RABBITMQ_QUEUE'], env: nil

	def work(raw_event)

		#event_params = JSON.parse(raw_event)
		puts raw_event
		
		ack!
	end

end
