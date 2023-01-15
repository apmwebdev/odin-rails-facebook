class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: %i[ destroy accept ]

  # GET /friend_requests or /friend_requests.json
  def index
    @friend_requests = FriendRequest.where(recipient_id: current_user.id)
      .includes(:sender)
  end

  # POST /friend_requests or /friend_requests.json
  def create
    @friend_request = FriendRequest.new(friend_request_params)
    @friend_request.status = "pending"

    if @friend_request.save
      redirect_to friend_request_url(@friend_request),
        notice: "Friend request was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /friend_requests/1 or /friend_requests/1.json
  def destroy
    @friend_request.destroy
    redirect_to friend_requests_url, notice: "Friend request deleted."
  end

  def accept
    user1 = @friend_request.sender
    user2 = @friend_request.recipient
    friendship = Friendship.new(user1:, user2:)
    if friendship.save
      @friend_request.destroy!
      redirect_to friend_requests_url, notice: "Accepted friend request!"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :recipient_id)
  end
end
