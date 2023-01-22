# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    super do |resource|
      UserMailer.with(user: resource).welcome_email.deliver_later
    end
  end

end
