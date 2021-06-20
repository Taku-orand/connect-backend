class AnswersController < ApplicationController
  def show
    answers = Answer.where(question_id: params[:id])
    if answers
      render json: { "answers" => answers }
    else
      render json: { message: "回答を取得できませんでした。"}
    end
  end
    
  def create
    details = receiveBody
    question = details[:question]
    answer = details[:answer]
    user = details[:user]

    puts "//////////"
    puts details
    puts user
    puts question
    puts "//////////"

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
    answerId = params[:id]
    answer = receiveBody
    target = Answer.find(answerId[:id])
    begin
      target.update!(
        content: answer[:content],
        anonymous: answer[:anonymous],
        like:answer[:like]
      )
      puts "変更できました"
    rescue ActiveRecord::RecordInvalid=> exception
      puts exception
      puts "変更できませんでした" 
    end
  end

  def destroy
    answerId = params[:id]
    target = Answer.find(answerId[:id])
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
