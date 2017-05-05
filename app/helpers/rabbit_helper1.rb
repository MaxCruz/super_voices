require 'bunny'

module RabbitHelper1

	def rmq_connect
		@connection = Bunny.new(ENV['RABBITMQ_BIGWIG_TX_URL'])
		@connection.start
		@channel = @connection.create_channel
		@queue = @channel.queue(ENV['RABBITMQ_QUEUE'], :auto_delete => false)
		@exchange = @channel.default_exchange
	end

	def rmq_disconnect
		@connection.close
	end

	def rmq_publish(message)
		@exchange.publish(message, :routing_key => @queue.name)
	end

	def rmq_count_messages
		return @queue.message_count
	end

	def rmq_count_consumers
		return @queue.consumer_count
	end

	def rmq_queue
		return @queue 
	end

	def rmq_channel
		return @channel
	end

end
