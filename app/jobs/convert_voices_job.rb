class ConvertVoicesJob < ApplicationJob
    
    include AwsHelper
    queue_as :default

    def perform
        sqs = sqs_client
        s3 = s3_client
        messages = sqs_messages(sqs)
        messages.each do |m|
            message = JSON.parse(m.body)
            id = message['id'].to_i
            name = message['name'].to_s
            email = message['email'].to_s
            contest_id = message['contest_id'].to_i
            contest = message['contest'].to_s
            input, output = create_io
            base_key = "#{contest_id}/#{id}"
            source_target = "#{input}/#{name}"
            name_converted = name_converted(name)
            destination_target = "#{output}/#{name_converted}"
            puts "Dowload the file #{name}"
            download_s3(s3, "#{base_key}/#{name}", source_target)
            puts "Convert #{source_target} To #{destination_target}"
            system "lame #{source_target} #{destination_target}"
            upload_s3(s3, "#{base_key}/#{name_converted}", destination_target) 
            sqs_delete_message(sqs, m.receipt_handle)
            send_email(email, contest)
            clear(input, output)
            puts "Done"
        end
    end

    def send_email(email, contest) 
        base_url = "http://www.supervoices.com" 
        UserMailer.converted_email(email, contest, base_url).deliver_later
    end

    def name_converted(name)
        return "#{File.basename(name, File.extname(name))}_output.mp3" 
    end

    def create_io
            path_input = "#{Rails.public_path}/uploads/tmp/in" 
            path_output = "#{Rails.public_path}/uploads/tmp/out" 
            system "mkdir -p #{path_input}" 
            system "mkdir -p #{path_output}"
            return path_input, path_output
    end

    def clear(path_input, path_output)
        system "rm -rf #{path_input}"
        system "rm -rf #{path_output}"
    end

end
