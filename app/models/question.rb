class Question < ApplicationRecord
  belongs_to :user

  has_one :like
  has_many :answers, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :notifications, dependent: :destroy

  def create_notification_answer!(current_user, question_title, answer_content, question_user)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    puts "aaaaaa"
    temp_ids = Answer.select(:user_id).where(question_id: id).where.not(user_id: current_user.id).distinct
    puts "bbbb"
    temp_ids.each do |temp_id|
      puts "cccccc"
      # ゲスト以外のアカウントのみ通知する
      if current_user.id != 0
        save_notification_answer!(current_user, question_title, answer_content, temp_id['user_id'])
      end
    end
    puts "ddddd"
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_answer!(current_user, question_title, answer_content, user_id) if temp_ids.blank?
    puts "eeeee"
  end
  
  def save_notification_answer!(current_user, question_title, answer_content, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    puts "ffffff"
    notification = current_user.active_notifications.new(
      question_id: id,
      visited_id: visited_id,
      answer_content: answer_content,
      visitor_name: current_user.name,
      question_title: question_title
    )
    puts "gggggg"
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      puts "hhhhh"
      notification.checked = true
    end
    puts "iiiiii"
    notification.save if notification.valid?
    puts "jjjjjj"
  end
end
