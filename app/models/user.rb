class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :omniauthable, omniauth_providers: %i[facebook]
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

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      name_arr = auth.info.name.split(" ")
      user.first_name = name_arr[0]
      user.last_name = name_arr[-1]
      # user.image = auth.info.image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

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
    UserProfile.create(user_id: self.id)
  end
end
