class ConvertVoicesJob < ApplicationJob
  queue_as :default

  def perform

  	Rails.logger.info("Convert Voices Job RUNNING at #{Time.now}")
  	
	Voice.where(done: false).find_each do |voice|
		source_path = Rails.root.to_s + "/public" + voice.source_url.to_s
		puts "Convert the voice: #{source_path}"
		destination_path = File.dirname(source_path) + "/out.mp3"
	    puts "To voice: #{destination_path}"
	    system "lame #{source_path} #{destination_path}"
	    voice.destination_url = destination_path
	    voice.done = true
	    voice.save!
	    UserMailer.converted_email(voice).deliver_later
	end
  end
end
