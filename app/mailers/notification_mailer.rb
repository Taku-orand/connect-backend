class NotificationMailer < ActionMailer::Base
  default from: ENV['EMAIL']

  def send_confirm_to_user(question, q_user, a_user, answer)
    @question = question
    @q_user = q_user
    @a_user = a_user
    @answer = answer
    mail(
      subject: @question[:title]+" - Connect 会津大学の知恵袋", #メールのタイトル
      to: @q_user[:email] #宛先
    ) do |format|
      format.text
    end
  end
end