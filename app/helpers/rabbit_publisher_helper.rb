require 'bunny'

module RabbitPublisherHelper

	def connect
		connection = Bunny.new(ENV['RABBITMQ_BIGWIG_TX_URL'])
		connection.start
		channel = connection.create_channel
		seilf.channel = channel
	end

	def publish(exchange_name, message)
		exchange = channel.fanout(exchange_name, durable: true)
		exchange.publish(message.to_json)
	end

	def disconect

	end

	private
	attr_accessor :channel

end
