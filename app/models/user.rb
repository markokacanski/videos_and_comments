require 'digest/sha1' 
class User < ActiveRecord::Base

  has_attached_file :avatar,
    path: Rails.application.config.paperclip_path,
    url: Rails.application.config.paperclip_url,
    styles: {
      thumbnail: ["320x180", :png]
    }

  validates_attachment :avatar,
    content_type: {
      content_type: /^image\/(jpg|gif|png|jpeg)/
    }

  has_attached_file :cover,
    path: Rails.application.config.paperclip_path,
    url: Rails.application.config.paperclip_url,
    styles: {
      thumbnail: ["320x180", :png]
    }

  validates_attachment :cover,
    content_type: {
      content_type: /^image\/(jpg|gif|png|jpeg)/
    }

  def password=(pw)
    self.password_hash = Digest::SHA1.hexdigest(pw)
  end

  def password_match(pw)
    if self.password_hash == Digest::SHA1.hexdigest(pw)
      return true
    else
      return false
    end
  end

  has_many :playlists
  has_many :videos
end
