require 'will_paginate/array'
require 'json'

class SitesController < ApplicationController

    include AwsHelper
    include RabbitHelper

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
            .order_by(:created_at => 'desc')
            .paginate(:page => params[:page], :per_page => 20)
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
        @voice.contest = @contest
        @voice.created_at = DateTime.now()
	@voice.converted = false
        respond_to do |format|
            if @voice.save
                message = {
                    'id' => @voice.id.to_s,
                    'name' => File.basename(@voice.source_url.file.path),
                    'email' => @voice.email,
                    'contest_id' => @voice.contest.id.to_s,
                    'contest' => @voice.contest.url
                }
		rmq_connect
		rmq_publish(JSON[message])
		rmq_disconnect
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
