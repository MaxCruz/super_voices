require 'bunny'

module RabbitPublisherHelper

	def connect
		@connection = Bunny.new(ENV['RABBITMQ_BIGWIG_TX_URL'])
		@connection.start
		channel = @connection.create_channel
		@queue = channel.queue(ENV['RABBITMQ_QUEUE'], :auto_delete => false)
		@exchange = channel.default_exchange
	end

	def publish(message)
		@exchange.publish(message, :routing_key => @queue.name)
	end

	def disconnect
		@connection.close
	end

end
