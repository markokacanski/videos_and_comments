class VideosController < ApplicationController
  def new
    users_only
    @video = Video.new  
  end

  def create
    users_only or return
    @video = Video.new

    @video.title = params[:video][:title]
    @video.description = params[:video][:description]
    @video.video_file = params[:video][:file]
    @video.user = current_user

    @video.save
  end

  def view
    @video = Video.find(params[:id])
    @video.view_count += 1
    @video.save
    @user = current_user
  end

  def list
    @videos = Video.all
  end

  def homepage
    @latest_videos = Video.all
  end
end