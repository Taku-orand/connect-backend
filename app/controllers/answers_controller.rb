class AnswersController < ApplicationController
  def show
    answers = Answer.where(question_id: params[:id])
    if answers
      render json: { "answers" => answers }
    else
      render json: { message: "回答を取得できませんでした。" }
    end
  end
    
  def create
    details = receiveBody
    question = details[:question]
    answer = details[:answer]
    user = details[:user]

    target = Answer.new(
      content: answer[:content],
      like: answer[:like],
      anonymous: answer[:anonymous],
      question_id: question[:id],
      user_id: user[:id],
    )

    begin
      target.save!
      puts "保存に成功しました"
      # 保存成功時の処理
    rescue ActiveRecord::RecordInvalid => e
      puts e
      puts "保存に失敗しました"
      # 保存失敗時の処理
    end
  end

  def update
    answer_id = params[:id]
    details = receiveBody
    answer = details[:answer]
    target = Answer.find_by(id: answer_id)
    begin
      if target.user_id == current_user[:id] then
        target.update!(
          content: answer[:content],
          anonymous: answer[:anonymous],
        )
        puts "変更できました"
      else
        puts "投稿者以外は内容に変更を加えることができません"        
      end
    rescue ActiveRecord::RecordInvalid => exception
      puts exception
      puts "変更できませんでした" 
    end
  end

  def destroy
    answer_id = params[:id]
    target = Answer.find_by(id: answer_id)
    begin
      if target.user_id == current_user[:id] then
        target.destroy!
        puts "削除に成功しました"
        # 保存成功時の処理
      else
        puts "投稿者以外は質問を削除することができません"
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
