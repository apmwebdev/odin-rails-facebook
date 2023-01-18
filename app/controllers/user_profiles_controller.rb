class UserProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
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

  def set_profile
    @profile = UserProfile.find_by(params[:user_id])
  end
end
