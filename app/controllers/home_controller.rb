class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :get_unread_count, only: :landing_page
  def landing_page
    if user_signed_in?
      redirect_to authenticated_root_path
    end
  end

end
