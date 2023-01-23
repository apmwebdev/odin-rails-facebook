# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

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
