# frozen_string_literal: true

module UsersHelper
  def name(user)
    user.first_name + " " + user.last_name
  end
end
