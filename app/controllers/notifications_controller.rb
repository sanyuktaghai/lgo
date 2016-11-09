class NotificationsController < ApplicationController
  def mark_as_read
    @user = current_user
    @notification = Notification.find(params[:id])
    @notification.update read: true
    respond_to do |format|
      if @notification.update(notification_params)
        format.html {redirect_to notifications_dashboard_path(@user) }
        format.js {render :partial => 'dashboard/notifications/markasread'}
      end
    end
  end
  
  private
  
  def notification_params
    params.permit(:read)
  end
end
