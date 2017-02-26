class ConvertVoicesJob < ApplicationJob
  queue_as :default

  def perform

  	Rails.logger.info("Convert Voices Job RUNNING at #{Time.now}")
  	
	Voice.where(done: false).find_each do |voice|
        source_path = voice.source_url.current_path
		#source_path = Rails.root.to_s + "/public" + voice.source_url.to_s
        output_file_name = File.basename(source_path, File.extname(source_path))
		puts "Convert the voice: #{source_path}"
        destination_path = File.dirname(source_path) + "/#{output_file_name}.mp3"
	    puts "To voice: #{destination_path}"
	    system "lame #{source_path} #{destination_path}"
        voice.destination_url = "/#{voice.source_url.store_dir}/#{output_file_name}.mp3" 
	    voice.done = true
	    voice.save!
        UserMailer.converted_email(voice, "http://www.supervoices.com").deliver_later
	end
    
  end
end
