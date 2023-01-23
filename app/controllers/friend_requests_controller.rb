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

    if @friend_request.save
      create_friend_request_notif(@friend_request)
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
      create_friendship_notif(friendship)
      @friend_request.destroy!
      redirect_to friend_requests_url, notice: "Accepted friend request!"
    end
  end

  def unfriend
    verified_params = unfriend_params
    friendship = Friendship::find_from_users(current_user.id, verified_params[:friend_id])
    friendship.destroy
    redirect_to request.referrer
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

  def unfriend_params
    params.require(:unfriend).permit(:friend_id)
  end

  def create_friendship_notif(friendship)
    n = Notification.new
    recipient_name = helpers.name(friendship.user2)
    n.title = "#{recipient_name} accepted your friend request!"
    n.body = "Hooray!"
    n.status = "unread"
    n.user_id = friendship.user1_id
    n.notifiable = friendship
    n.save
  end

  def create_friend_request_notif(friend_request)
    n = Notification.new
    sender_name = helpers.name(friend_request.sender)
    n.title = "New friend request from #{sender_name}"
    n.body = "Would you like to accept this friend request?"
    n.status = "unread"
    n.user_id = friend_request.recipient_id
    n.notifiable = friend_request
    n.save
  end
end
