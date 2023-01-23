class Friendship < ApplicationRecord
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"
  has_one :notification, as: :notifiable

  def self.find_from_users(user1_id, user2_id)
    Friendship.find_by("(user1_id = ? AND user2_id = ?) OR (user1_id = ? AND user2_id = ?)",
      user1_id, user2_id, user2_id, user1_id)
  end
end
