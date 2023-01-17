class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: "User"
  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user
  has_one :notification, as: :notifiable

  attr_accessor :turbo_target
end
