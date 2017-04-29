require 'bunny'

module RabbitPublisherHelper

	def connect
		@connection = Bunny.new(ENV['RABBITMQ_BIGWIG_TX_URL'])
		@connection.start
		channel = @connection.create_channel
		@queue = channel.queue(ENV['RABBITMQ_QUEUE'], :auto_delete => true)
		@exchange = channel.default_exchange
	end

	def publish(message)
		@exchange.publish(message, :routeing_key => @queue.name)
	end

	def disconect
		@connection.close
	end

end
