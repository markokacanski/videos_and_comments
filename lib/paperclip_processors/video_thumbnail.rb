require "streamio-ffmpeg"
class Paperclip::VideoThumbnail < Paperclip::Processor
  def make
    movie = FFMPEG::Movie.new(@file.path)
    scr = Tempfile.new(File.basename(@file.path))
    movie.screenshot(scr.path, resolution: '320x180')

    return scr
  end
end