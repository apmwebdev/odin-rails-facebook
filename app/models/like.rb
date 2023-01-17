class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user
  has_one :notification, as: :notifiable

  attr_accessor :turbo_target
end
