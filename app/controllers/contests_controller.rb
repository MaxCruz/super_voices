class ContestsController < ApplicationController
    before_action :set_contest, only: [:show, :edit, :update, :destroy]
    before_filter :authorize

    # GET /contests
    def index
        @contests = Contest.where(administrator_id: current_user.id).order(created_at: :desc)
    end

    # GET /contests/1
    def show
        @voices = Voice.where(contest_id: @contest.id)
            .paginate(:page => params[:page], :per_page => 50)
            .order(created_at: :desc)
    end

    # GET /contests/new
    def new
        @contest = Contest.new
    end

    # GET /contests/1/edit
    def edit
    end

    # POST /contests
    def create
        @contest = Contest.new(contest_params)
        @contest.administrator = current_user
        respond_to do |format|
            if @contest.save
                format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
            else
                format.html { render :new }
            end
        end
    end

    # PATCH/PUT /contests/1
    def update
        respond_to do |format|
            if @contest.update(contest_params)
                format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end

    # DELETE /contests/1
    def destroy
        FileUtils.rm_rf("public/uploads/contest/image/#{@contest.id}")
        FileUtils.rm_rf("public/uploads/voice/#{@contest.id}")
        @contest.destroy
        respond_to do |format|
            format.html { redirect_to contests_url, notice: 'Contest was successfully destroyed.' }
        end
    end

    private
    def set_contest
        @contest = Contest.find(params[:id])
    end

    def contest_params
        params.require(:contest).permit(:name, :image, :url, :start_date, :end_date, :reward, :script, :recomendations)
    end

end
