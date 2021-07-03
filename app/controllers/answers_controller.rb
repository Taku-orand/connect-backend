class AnswersController < ApplicationController
  def show
    question_id = params[:id]
    answers = Answer.joins(:user, :like).select('answers.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').order(like_count: "DESC")
    answers = answers.where(question_id: question_id)

    if answers
      render json: { "answers" => answers }
    else
      render json: { message: "回答を取得できませんでした。"}
    end
  end
    
  def create
    details = receiveBody
    answer = details[:answer]
    user = User.find(current_user.id)
    target = user.answers.new(answer)
    like = target.build_like(count: 0)

    begin
      target.save!
      like.save!
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
    target = Answer.find_by(id: answer_id)
    begin
      target.update!(
        content: answer[:content],
        anonymous: answer[:anonymous],
      )
      puts "変更できました"
    rescue ActiveRecord::RecordInvalid=> exception
      puts exception
      puts "変更できませんでした" 
    end
  end

  def destroy
    answer_id = params[:id]
    target = Answer.find_by(id: answer_id)
    begin
      target.destroy!
      puts "削除に成功しました"
      # 保存成功時の処理
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
