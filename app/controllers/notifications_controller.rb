class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[ show edit destroy ]

  # GET /notifications or /notifications.json
  def index
    @notifications = Notification.where(user_id: current_user.id)
  end

  # GET /notifications/1 or /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications or /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to notification_url(@notification), notice: "Notification was successfully created." }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1 or /notifications/1.json
  def update
    verified_params = notification_params
    @notification = Notification.find(verified_params[:id])
    if @notification.update(verified_params)
      redirect_to notifications_path, notice: "Notification successfully updated"
    else
      render :index, status: :unprocessable_entity
    end
  end

  # DELETE /notifications/1 or /notifications/1.json
  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: "Notification dismissed"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def notification_params
    params.require(:notification).permit(:id, :status)
  end
end
