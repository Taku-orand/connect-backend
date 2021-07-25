class NotificationsController < ApplicationController
  def index
    notifications = current_user.passive_notifications.page(params[:page]).per(20)

    # 処理追加
    # checked: trueの通知を削除する

    # 確認済みにする処理
    notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
      puts notification
    end
    render json: {"notifications": notifications}
  end
end
