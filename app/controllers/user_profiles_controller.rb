class UserProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_profile_path(@profile), notice: "profile updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create_for_existing_users
    counter = 0
    User.find_each do |user|
      unless UserProfile.where(user_id: user.id).exists?
        UserProfile.create(user_id: user.id)
        counter += 1
      end
    end
    redirect_to request.referrer, notice: "#{counter} profile(s) created"
  end

  private

  def profile_params
    params.require(:user_profile).permit(:user_id, :birthday, :gender, :bio,
      :country, :city)
  end

  def set_profile
    @profile = UserProfile.find(params[:id])
  end
end
