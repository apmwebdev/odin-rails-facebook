class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: %i[ show edit update destroy ]

  # GET /friend_requests or /friend_requests.json
  def index
    @friend_requests = FriendRequest.all
  end

  # GET /friend_requests/1 or /friend_requests/1.json
  def show
  end

  # GET /friend_requests/new
  def new
    @friend_request = FriendRequest.new
  end

  # POST /friend_requests or /friend_requests.json
  def create
    @friend_request = FriendRequest.new(friend_request_params)

    if @friend_request.save
      format.html { redirect_to friend_request_url(@friend_request), notice: "Friend request was successfully created." }
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  # DELETE /friend_requests/1 or /friend_requests/1.json
  def destroy
    @friend_request.destroy

    format.html { redirect_to friend_requests_url, notice: "Friend request was successfully destroyed." }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :recipient_id, :status)
  end
end
