require 'digest/sha1' 
class User < ActiveRecord::Base

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
end
