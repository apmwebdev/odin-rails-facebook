# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController

  protected

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    UserMailer.with(user: resource).welcome_email.deliver_later
    super(resource_name, resource)
  end
end
