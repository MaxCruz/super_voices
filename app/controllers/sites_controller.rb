class SitesController < ApplicationController
    before_action :set_contest 

    def get_message
        return 'We have received your voice and we are processing it so that it can ' + 
            'be published in the page of the contest and can be later reviewed by ' + 
            'our team. As soon as the voice is published in the contest page we ' + 
            'will notify you by email.'
    end

    def index 
        @voices = Voice.where(contest_id: @contest.id, done: true).order(created_at: :desc)
        render layout: "application_site"
    end

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
