class ConvertVoicesJob < ApplicationJob
  queue_as :default

  def perform
    start = Time.now
  	found_voices = Voice.where(done: false) 
    number = found_voices.size
	found_voices.find_each do |voice|


        source_path = voice.source_url.current_path
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
    finish = Time.now
    logger = Logger.new('log/conver_voice_job.log')
    logger.info "#{start.localtime}, #{number}, #{finish-start}"
  end

end
