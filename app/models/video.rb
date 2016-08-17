class Video < ActiveRecord::Base
  has_attached_file :video_file,
    path: Rails.application.config.paperclip_path,
    url: Rails.application.config.paperclip_url,
    styles: {
      thumbnail: ["320x180", :png]
    },
    processors: [:video_thumbnail]

  validates_attachment :video_file,
    content_type: {
      content_type: /^video\/(mp4|ogg|webm)/
    }


  belongs_to :user
end
