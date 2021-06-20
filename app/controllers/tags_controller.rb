class TagsController < ApplicationController
  def index
    tags = Tag.all
    if tags
      render json: { tags: tags }
    else
      render json: { message: "タグを取得できませんでした。" }
    end
  end

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
  
  def create
    tag = receiveBody
    target = Tag.new(tag)
    begin
      target.save!
      puts "保存成功"
    rescue ActiveRecord::RecordInvalid => exception
      puts exception
      puts "保存失敗"
    end
  end

  def destroy
    tag_id = params[:id]
    target = Tag.find_by(id: tag_id)
    begin
      target.destroy!
      puts "保存成功"
    rescue ActiveRecord::RecordInvalid => exception
      puts exception
      puts "保存失敗"
    end
  end

  def update
    tag_id = params[:id]
    tag = receiveBody
    target = Tag.find_by(id: tag_id)
    begin
      target.update!(name: tag[:name])
    rescue ActiveRecord::RecordInvalid=> exception
      puts exception
    end
  end
  
  def receiveBody
   JSON.parse(request.body.read, {:symbolize_names => true})
  end
end
