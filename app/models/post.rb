class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  def self.newsfeed(user)
    Post.where(author_id: user.friend_ids).or(Post.where(author: user))
      .includes(:author).order(created_at: :desc)

  end
end
