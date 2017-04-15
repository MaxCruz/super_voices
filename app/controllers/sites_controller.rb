require 'json'

class SitesController < ApplicationController

    include AwsHelper

    before_action :set_contest 

    def get_message
        return 'We have received your voice and we are processing it so that it can ' + 
            'be published in the page of the contest and can be later reviewed by ' + 
            'our team. As soon as the voice is published in the contest page we ' + 
            'will notify you by email.'
    end

    # GET /sites/:key
    def index 
        @voices = Voice.where(contest_id: @contest.id)
            .paginate(:page => params[:page], :per_page => 20)
            .order(created_at: :desc)
        render layout: "application_site"
    end

    # GET /sites/:key/new
    def new
        @voice = Voice.new
        render layout: "application_site"
    end

    # POST /sites/:key
    def create
        @voice = Voice.new(voice_params)
        @voice.contest_id = @contest.id
        respond_to do |format|
            if @voice.save
                message = {
                    'id' => @voice.id,
                    'name' => @voice.source_url.file.filename,
                    'email' => @voice.email,
                    'contest_id' => @voice.contest.id,
                    'contest' => @voice.contest.url
                }
                sqs = sqs_client
                sqs_send_message(sqs, JSON[message])
                format.html { redirect_to "/sites/" + @contest.url, notice: get_message }
            else
                format.html { render :new, layout: "application_site" }
            end
        end
    end

    private
    def set_contest
        @contest = Contest.find_by(url: params[:key])
    end

    def voice_params
        params.require(:voice).permit(:email, :name, :last_name, :message, :source_url)
    end

end
