class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :user_profile
  has_many :friend_requests
  has_many :notifications
  has_many :comments, foreign_key: "commenter_id"
  has_many :likes
  has_many :liked_posts, through: :likes, source: :likeable,
    source_type: "Post"
  has_many :liked_comments, through: :likes, source: :likeable,
    source_type: "Comment"
  after_create_commit :create_profile

  def friendships
    Friendship.where("user1_id = ? OR user2_id = ?", self.id, self.id)
  end

  def friend_ids
    friendships.map do |friendship|
      next friendship.user1_id unless friendship.user1_id == self.id
      friendship.user2_id
    end
  end

  def friends
    User.where(id: friend_ids)
  end

  def friends_with?(user_or_id)
    other = if user_or_id.is_a?(User)
      user_or_id.id
    elsif user_or_id.is_a?(String)
      user_or_id.to_i
    else
      user_or_id
    end
    Friendship.where("user1_id = ? AND user2_id = ?", self.id, other)
      .or(Friendship.where("user1_id = ? AND user2_id = ?", other, self.id))
      .exists?
  end

  private

  def create_profile
    profile = self.user_profile.build
    profile.save
  end
end
