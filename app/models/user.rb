class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friend_requests

  def friendships
    Friendship.where("user1_id = ? OR user2_id = ?", self.id, self.id)
  end

  def friends
    friendships_data = friendships.map do |record|
      next record.user1_id unless record.user1_id == self.id
      record.user2_id
    end
    User.where(id: friendships_data)
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
end
