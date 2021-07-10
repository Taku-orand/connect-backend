class QuestionsController < ApplicationController
  def index
    questions = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').order(created_at: "DESC")
    
    if questions
      render json: { "questions" => questions }
    else
      render json: { message: "質問またはタグを受け取れませんでした。" }
    end
  end

    def show
    question = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').find(params[:id])
    
    if question
      render json: { "question" => question }
    else 
      render json: { message: "質問または返信を受け取れませんでした。" }
    end
  end

  def user
    puts current_user
    questions = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').where(user_id: current_user.id).order(created_at: "DESC")
    
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
    target = Question.find(question_id)

    begin
      if target.user_id == current_user.id then
        target.update!(
          title: question[:title],
          content: question[:content],
          anonymous: question[:anonymous],
          solved: question[:solved]
        )
        puts "変更できました"
        render json: {update_question: true}
      else
        puts "投稿者以外は内容に変更を加えることができません"
      end
    rescue ActiveRecord::RecordInvalid=> exception
      puts exception
      puts "変更できませんでした"   
      render json: {update_question: false}
    end
  end

  def create
    details = receiveBody
    question = details[:question]
    user = User.find(current_user.id)
    target = user.questions.new(question)
    like = target.build_like(count: 0)

    begin
      target.save!
      like.save!
      render json: {posted: true}
    rescue ActiveRecord::RecordInvalid => exception
      puts exception
      render json: {posted: false}
    end
  end

  def destroy
    question_id = params[:id]
    target = Question.find(question_id)

    begin
      if target.user_id == current_user.id then
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