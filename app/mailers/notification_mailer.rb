class NotificationMailer < ActionMailer::Base
  default from: "uoastudent182@gmail.com"

  def send_confirm_to_user(user)
    @user = user
    mail(
      subject: "あなた宛に回答が届いています。 Connect 会津大学の知恵袋", #メールのタイトル
      to: @user.email #宛先
    ) do |format|
      format.text
    end
  end
end