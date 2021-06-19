class AnswersController < ApplicationController
  # def index
  #   questions = Question.all
  #   answers = Answer.all
  #   if questions and answers and 
  #   render json: { "questions" => questions,"answers" => answers}
  # end

  def create
    answer = receiveBody
    target = Answer.new(answer)
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
