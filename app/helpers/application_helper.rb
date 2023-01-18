require "digest"

module ApplicationHelper
  def name(user)
    user.first_name + " " + user.last_name
  end

  def get_like_of_user(likeable, user)
    Like.find_by(likeable:, user:)
  end

  def get_gravatar_url(email)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    "https://www.gravatar.com/avatar/#{hash}?d=robohash"
  end
end
