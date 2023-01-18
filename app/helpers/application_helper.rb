require "digest"

module ApplicationHelper
  def name(user)
    user.first_name + " " + user.last_name
  end

  def get_like_of_user(likeable, user)
    Like.find_by(likeable:, user:)
  end

  def get_gravatar_url(email, img_size = nil)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    url = "https://www.gravatar.com/avatar/#{hash}?d=robohash"
    if img_size
      url += "&s=#{img_size}"
    end
    url
  end
end
