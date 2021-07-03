class QuestionsController < ApplicationController
  def index
    questions = Question.all.order(created_at: "DESC")
    if questions
      render json: { "questions" => questions }
    else
      render json: { message: "質問またはタグを受け取れませんでした。" }
    end
  end

  def show
    question = Question.select('questions.*, users.id AS user_id, users.name AS user_name, likes.count AS like_id,likes.count AS like_count').joins(:like, :user).where(id: params[:id])
    tags = question[0].tags.all
    if question
      render json: question.to_json(include: :tags)
    else 
      render json: { message: "質問または返信を受け取れませんでした。" }
    end
  end

  def user
    puts current_user
    questions = Question.where(user_id: current_user.id)
    if questions
      render json: { get_my_questions: true, questions: questions}
    else 
      render json: { get_my_questions: false}
    end
  end

  def update
    question_id = params[:id]
    question_details = receiveBody
    question = question_details[:question]
    target = Question.find_by(id: question_id)
    begin
      if target.user_id == current_user[:id] then
        target.update!(
          title: question[:title],
          content: question[:content],
          anonymous: question[:anonymous]
        )
        puts "変更できました"
      else
        puts "投稿者以外は内容に変更を加えることができません"
      end
    rescue ActiveRecord::RecordInvalid=> exception
      puts exception
      puts "変更できませんでした"   
    end
  end

  def create
    body = receiveBody
    user = User.find(current_user[:id])
    question = body[:question]
    target = user.questions.new(question)
    begin
      target.save!
      puts "保存成功"
      render json: {posted: true}
    rescue ActiveRecord::RecordInvalid => exception
      puts exception
      puts "保存失敗"
      render json: {posted: false}
    end
  end

  def destroy
    question_id = params[:id]
    target = Question.find_by(id: question_id)
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