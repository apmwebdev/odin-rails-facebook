class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing_page
  def landing_page
    if user_signed_in?
      render :newsfeed
    end
  end

  def newsfeed
    unless user_signed_in?
      render :landing_page
    end
  end
end
