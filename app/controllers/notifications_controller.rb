class NotificationsController < ApplicationController
  def index
    notifications = current_user.passive_notifications.page(params[:page]).per(10)
    notifications.where(checked: false).each do |notification|
      notification.update_attribute(checked: true)
    end
    render json: {"notifications": notifications}
  end
end
