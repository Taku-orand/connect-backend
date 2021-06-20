class QuestionsController < ApplicationController
  def index
    questions = Question.all.order(created_at: "DESC")
    if questions
      render json: { "questions" => questions }
    else
      render json: { message: "質問またはタグを受け取れませんでした。"}
    end
  end

  def show
    question = Question.find(params[:id])
    answers = Answer.find_by(question_id: params[:id])
    question_tags = question.tags
    tags = Tag.all
    if question
      render json: { "question" => question}
    else 
      render  json: { message: "質問または返信を受け取れませんでした。"}
    end
  end

  def update
    questionId = params[:id]
    question = receiveBody
    target = Question.find(questionId[:id])
    begin
      target.update!(
        title: question[:title],
        content: question[:content],
        anonymous: question[:anonymous],
        like: question[:like]
      )
      puts "変更できました"
    rescue ActiveRecord::RecordInvalid=> exception
      puts exception
      puts "変更できませんでした"   
    end
  end

  def create
    question = receiveBody
    target = question.new(question)
    begin
      target.save!
      puts "保存成功"
    rescue ActiveRecord::RecordInvalid => exception
      puts exception
      puts "保存失敗"
    end
  end

  def destroy
    questionId = params[:id]
    target = Question.find(questionId[:id])
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
