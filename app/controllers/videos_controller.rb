class VideosController < ApplicationController
  def new
    users_only
    @video = Video.new  
  end

  def create
    video = Video.new

    video.title = params[:video][:title]
    video.description = params[:video][:description]
    video.video_file = params[:video][:file]

    video.save
  end

  def view
    @video = Video.find(params[:id])
    @video.view_count += 1
    @video.save
  end

  def list
    @videos = Video.all
  end
end