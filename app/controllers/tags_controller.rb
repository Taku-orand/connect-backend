class TagsController < ApplicationController
  # 全タグを取得
  def index
    tags = Tag.all
    if tags
      render json: { tags: tags }
    else
      render json: { message: "タグを取得できませんでした。" }
    end
  end

  # showメソッドは使ってない
  def show
    question_id = params[:id]
    question = Question.find_by(id: question_id)
    question_tags = question.tags
    if question_tags
      render json: { tags: question_tags }
    else
      render json: { message: "タグを取得できませんでした。" }
    end
  end
  
  # タグを作成（createメソッドは使ってない）
  def create
    tag = receiveBody
    target = Tag.new(tag)
    begin
      # タグ保存成功
      target.save!
    rescue ActiveRecord::RecordInvalid => exception
      # タグ保存失敗
    end
  end

  # タグを削除する
  def destroy
    tag_id = params[:id]
    target = Tag.find_by(id: tag_id)
    begin
      # タグ削除成功
      target.destroy!
    rescue ActiveRecord::RecordInvalid => exception
      # タグ削除失敗
    end
  end

  # タグ名を編集
  def update
    tag_id = params[:id]
    tag = receiveBody
    target = Tag.find_by(id: tag_id)
    begin
      target.update!(name: tag[:name])
    rescue ActiveRecord::RecordInvalid=> exception
      # タグ編集失敗
    end
  end
  
  def receiveBody
    JSON.parse(request.body.read, {:symbolize_names => true})
  end
end
