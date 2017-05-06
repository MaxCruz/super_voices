class HirefireController < ApplicationController

	include RabbitHelper1

	def queue
		rmq_connect
		messages = rmq_count_messages
		msg = { :name => "worker", :quantity => messages }
		array= [ msg ]
		render status: 200, json: array.to_json
		rmq_disconnect
	end

end
