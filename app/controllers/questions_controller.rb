class QuestionsController < ApplicationController
  # 全ての質問を作成日降順で返す
  def index
    questions = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').order(created_at: "DESC")
    
    if questions
      render json: { "questions" => questions }
    else
      render json: { message: "質問またはタグを受け取れませんでした。" }
    end
  end

  # 質問の詳細を返す
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

  # 質問を編集する
  def update
    question_id = params[:id]
    question_details = receiveBody
    question = question_details[:question]
    target = Question.find(question_id)

    begin
      # 投稿主と現在のユーザーが一致するときのみ、編集可能
      if target.user_id == current_user.id then
        target.update!(
          title: question[:title],
          content: question[:content],
          anonymous: question[:anonymous],
          solved: question[:solved]
        )
        render json: {update_question: true}
      else
        # 投稿者以外は内容に変更を加えることができません"
      end
    rescue ActiveRecord::RecordInvalid=> exception
      # エラーにより、編集できなかった場合
      render json: {update_question: false}
    end
  end

  # 質問を投稿
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
      render json: {posted: false}
    end
  end

  # 質問削除(質問の削除はしない方針)
  def destroy
    question_id = params[:id]
    target = Question.find(question_id)

    begin
      if target.user_id == current_user.id then
        # 削除成功時の処理
        target.destroy!
        render json: {"delete_question": true}
      else
        # 投稿者以外は質問を削除することができません
      end
    rescue ActiveRecord::RecordInvalid => e
      # 保存失敗時の処理
      render json: {"delete_question": false}
    end
  end

  private
  def receiveBody
   JSON.parse(request.body.read, {:symbolize_names => true})
  end
end