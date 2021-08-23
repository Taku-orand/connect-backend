class AnswersController < ApplicationController
  # 質問に関連する返信を取得
  def show
    question_id = params[:id]
    answers = Answer.joins(:user, :like).select('answers.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').where(question_id: question_id).order(like_count: "DESC")

    if answers
      # 返信を返す
      render json: { answers: answers }
    else
      # 返信がなかった場合
      render json: { message: "回答を取得できませんでした。"}
    end
  end

  # 返信を投稿
  def create
    details = receiveBody
    answer = details[:answer]
    user = User.find(current_user.id)
    target = user.answers.new(answer)
    like = target.build_like(count: 0)

    begin
      # 返信保存
      target.save!
      like.save!
      render json: {created_answer: true}
    rescue ActiveRecord::RecordInvalid => e
      # 返信保存エラー
      render json: {created_answer: false}
    end
  end

  # 質問編集
  def update
    answer_id = params[:id]
    details = receiveBody
    answer = details[:answer]
    target = Answer.find(answer_id)
    begin
      if target.user_id == current_user.id then
        # 質問をアップデート
        target.update!(
          content: answer[:content],
          anonymous: answer[:anonymous]
        )
        updated_answer = true
      else
        # 投稿者以外は内容に変更を加えることができません"
      end
    rescue ActiveRecord::RecordInvalid=> exception
      # 編集できない場合
      updated_answer = false
    end
    render json: {"updated_answer" => updated_answer}
  end

  # 返信を削除（今は削除できないようにしている）
  def destroy
    answer_id = params[:id]
    target = Answer.find(answer_id)
    begin
      if target.user_id == current_user.id then
        target.destroy!
        # 保存成功時の処理
      else
        # 投稿者以外は内容に変更を加えることができません
      end
    rescue ActiveRecord::RecordInvalid => e
      # 保存失敗時の処理
    end
  end

  private
  def receiveBody
    JSON.parse(request.body.read, {:symbolize_names => true})
  end
end
