class VideosController < ActionController::Base
  def new
   @video = Video.new  
  end

  def create
    video = Video.new

    video.title = "title goes here"
    video.description = "description goes here"
    video.video_file = params[:video][:file]

    video.save
  end
end