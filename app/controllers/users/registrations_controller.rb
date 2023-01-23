# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # POST /users
  def create
    super do |resource|
      UserMailer.with(user: resource).welcome_email.deliver_later
    end
  end

  # DELETE /users
  def destroy
    if UserProfile.destroy(resource.id)
      resource.destroy
      Devise.sign_out_all_scopes
      set_flash_message! :notice, :destroyed
      redirect_to root_path
    end
  end

end
