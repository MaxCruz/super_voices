class ApplicationController < ActionController::Base

    include AwsHelper

    protect_from_forgery with: :null_session

    def current_user
        if session[:user_id] 
            count = Administrator.where("_id": session[:user_id]).count()
            if count == 0
                session.delete(:message)
            else
                @current_user = Administrator.find(session[:user_id])
            end
        end
    end

    helper_method :current_user

    def converted_voice(voice)
        done = false
        url = ""
        file = ""
        name = voice.source_url.file.path
        basename = "#{File.basename(name, File.extname(name))}_output.mp3"
        key = "#{voice.contest.id}/#{voice.id}/#{basename}"
        s3 = s3_client
        if file_exist_s3(s3, key)
            done = true
            url = "http://d2va84y79r496d.cloudfront.net/#{key}"
            #url = "https://s3.amazonaws.com/#{ENV["AWS_BUCKET"]}/#{key}"
            file = basename
        end
        return done, url, file
    end

    helper_method :converted_voice


    def authorize
        redirect_to "/login" unless current_user
    end

end
