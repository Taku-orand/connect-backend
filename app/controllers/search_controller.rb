class SearchController < ApplicationController
  #文字列検索
  def searchByWord
    tags = Tag.all
    title = params[:title]
    questions = Question.find_by(title: title)
    render json: {"tags"=>tags, "questions"=>questions}
  end

  #タグ検索
  def searchByTag
    tags = Tag.all
    #/tags/2/search の場合、id２のタグ取得
    tag = Tag.find(params[:tag_id]) 
    #tagに関連するquestionを全取得
    questions = tag.questions.all
    render json: {"tags" => tags, "questions"=>questions}
  end
end
