module ApplicationHelper
  def name(user)
    user.first_name + " " + user.last_name
  end

  def get_like_of_user(likeable, user)
    Like.find_by(likeable:, user:)
  end
end
