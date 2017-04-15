require 'aws-sdk'

module AwsHelper

    def credentials
        return Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"]) 
    end

    def sqs_client
        return Aws::SQS::Client.new(region: ENV["AWS_REGION"], credentials: credentials)
    end

    def sqs_url(sqs)
        resp = sqs.create_queue(queue_name: ENV["AWS_QUEUE"])
        return resp.queue_url
    end

    def sqs_messages(sqs)
        result = sqs.receive_message({
            queue_url: sqs_url(sqs), 
            max_number_of_messages: 1
        })
        return result.messages
    end

    def sqs_send_message(sqs, body)
        sqs.send_message(
            queue_url: sqs_url(sqs),
            message_body: body
        )
    end

    def sqs_delete_message(sqs, receipt)
        sqs.delete_message({
            queue_url: sqs_url(sqs),
            receipt_handle: receipt
        })
    end

    def s3_client
        return Aws::S3::Client.new(region: ENV["AWS_REGION"], credentials: credentials)
    end

    def download_s3(s3, key, destination_file)
        s3.get_object(
            bucket: ENV["AWS_BUCKET"], 
            key: key, 
            response_target: destination_file
        )
    end

    def upload_s3(s3, key, source_file)
        File.open(source_file, 'rb') do |file|
            s3.put_object(
                bucket: ENV["AWS_BUCKET"],
                key: key,
                body: file
            )
        end
    end

    def delete_s3(s3, key)
        resp = s3.list_objects_v2(bucket: ENV["AWS_BUCKET"])
        resp.contents.each do |obj|
            if obj.key.start_with?(key)
                s3.delete_object({
                    bucket: ENV["AWS_BUCKET"],
                    key: obj.key
                })
            end
        end
    end

    def file_exist_s3(s3, key)
        resp = s3.list_objects_v2(bucket: ENV["AWS_BUCKET"])
        resp.contents.each do |obj|
            if obj.key.start_with?(key)
                return true
            end
        end
        return false
    end

end
