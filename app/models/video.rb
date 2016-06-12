class Video < ActiveRecord::Base
  has_attached_file :video_file,
    path: Rails.application.config.paperclip_path
  validates_attachment :video_file,
    content_type: {
      content_type: /^video\/(mp4|ogg|webm)/
    }
end
