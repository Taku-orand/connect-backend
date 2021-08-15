class QuestionsController < ApplicationController
  # 全ての質問を作成日降順で返す
  def index
    questions = Question.includes(:tags, :user, :like).order(created_at: :desc)
    if questions
      render json: { "questions": build_questions(questions) }
    else
      render json: { message: "質問またはタグを受け取れませんでした。" }
    end
  end

  # 質問の詳細を返す
  def show
    question = Question.includes(:tags, :user, :like).find(params[:id])
    
    if question
      render json: { "question" => build_questions([question]) }
    else 
      render json: { message: "質問または返信を受け取れませんでした。" }
    end
  end


  # マイページの質問
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
  # questionsオブジェクトを作る。
  def build_questions(questions)
    questions.each_with_object([]) do |question, arr|
      # << は配列の末尾に追加するもの（ただし、一つしかいれられない=>複数追加したい場合、pushを使えばいい）
      arr << question_content(question)
    end
  end

  # 質問、タグをオブジェクトで返す。
  def question_content(question)
    {
      id:question.id,
      title: question.title,
      content: question.content,
      anonymous: question.anonymous,
      created_at: question.created_at,
      updated_at: question.updated_at,
      tags: question.tags.map { |tag| { name: tag.name} },
      user_id: question.user.id,
      user_name: question.user.name,
      like_count: question.like.count,
      like_id: question.like.id
    }
  end
end