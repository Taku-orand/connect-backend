class AnswersController < ApplicationController
  def show
    question_id = params[:id]
    answers = Answer.joins(:user, :like).select('answers.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').where(question_id: question_id).order(like_count: "DESC")

    if answers
      render json: { answers: answers }
    else
      render json: { message: "回答を取得できませんでした。"}
    end
  end
  
  def create
    details = receiveBody
    answer = details[:answer]
    answer_user = User.find(current_user.id)
    target = answer_user.answers.new(answer)
    like = target.build_like(count: 0)
    question = Question.find(target.question_id)
    question_user = User.find(question.user_id)

    begin
      target.save!
      like.save!
      question.create_notification_answer!(answer_user, target.content, question_user)
      NotificationMailer.send_confirm_to_user(question, question_user, answer_user, answer).deliver
      render json: {created_answer: true}
    rescue ActiveRecord::RecordInvalid => e
      puts e
      render json: {created_answer: false}
    end
  end

  def update
    answer_id = params[:id]
    details = receiveBody
    answer = details[:answer]
    target = Answer.find(answer_id)
    begin
      if target.user_id == current_user.id then
        target.update!(
          content: answer[:content],
          anonymous: answer[:anonymous]
        )
        puts "変更できました"
        updated_answer = true
      else
        puts "投稿者以外は内容に変更を加えることができません"
      end
    rescue ActiveRecord::RecordInvalid=> exception
      puts exception
      puts "変更できませんでした" 
      updated_answer = false
    end
    render json: {"updated_answer" => updated_answer}
  end

  def destroy
    answer_id = params[:id]
    target = Answer.find(answer_id)
    begin
      if target.user_id == current_user.id then
        target.destroy!
        puts "削除に成功しました"
        # 保存成功時の処理
      else
        puts "投稿者以外は内容に変更を加えることができません"
      end
    rescue ActiveRecord::RecordInvalid => e
      puts e
      puts "削除に失敗しました"
      # 保存失敗時の処理
    end
  end

  private
  def receiveBody
    JSON.parse(request.body.read, {:symbolize_names => true})
  end
end
