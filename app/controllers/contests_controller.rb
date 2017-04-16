require 'will_paginate/array'

class ContestsController < ApplicationController

    include AwsHelper

    before_action :set_contest, only: [:show, :edit, :update, :destroy]
    before_action :authorize

    # GET /contests
    def index
        @contests = Contest.where(administrator_id: current_user.id).order(created_at: :desc)
    end

    # GET /contests/1
    def show
        @voices = Voice.where(contest_id: @contest.id)
            .order_by(:created_at => 'desc')
            .paginate(:page => params[:page], :per_page => 50)
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
        sy = contest_params["start_date(1i)"].to_i
        sm = contest_params["start_date(2i)"].to_i
        sd = contest_params["start_date(3i)"].to_i
        @contest.start_date = Date.new(sy, sm, sd)
        ey = contest_params["end_date(1i)"].to_i
        em = contest_params["end_date(2i)"].to_i
        ed = contest_params["end_date(3i)"].to_i
        @contest.end_date = Date.new(ey, em, ed)
        @contest.created_at = DateTime.now()
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
            @contest.name = contest_params[:name]
            @contest.image = contest_params[:image]
            @contest.url = contest_params[:url]
            sy = contest_params["start_date(1i)"].to_i
            sm = contest_params["start_date(2i)"].to_i
            sd = contest_params["start_date(3i)"].to_i
            @contest.start_date = Date.new(sy, sm, sd)
            ey = contest_params["end_date(1i)"].to_i
            em = contest_params["end_date(2i)"].to_i
            ed = contest_params["end_date(3i)"].to_i
            @contest.end_date = Date.new(ey, em, ed)
            @contest.reward = contest_params[:reward]
            @contest.script = contest_params[:script]
            @contest.recomendations = contest_params[:recomendations]
            if @contest.save()
                format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end

    # DELETE /contests/1
    def destroy
        s3 = s3_client 
        delete_s3(s3, "#{@contest.id}/")
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
