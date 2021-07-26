class NotificationsController < ApplicationController
  # 通知を取得
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

  #通知を全削除
  def destroy
    notifications = current_user.passive_notifications
    # 通知がなかった場合
    puts notifications.length
    if notifications.length == 0
      render json: {"delete_notifications": false}
      return 
    end

    notifications.each do |notification|
      begin
        notification.destroy!
      rescue => exception
        render json: {"delete_notifications": false}
        return 
      end
    end
    render json: {"delete_notifications": true}
  end
end
