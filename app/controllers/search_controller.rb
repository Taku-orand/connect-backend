class SearchController < ApplicationController
  #文字列検索
  def searchByWord
    word = params[:word]
    questions = Question.where('title like ? OR content like ?', "%#{word}%", "%#{word}%").order(created_at: "DESC")
    if questions.length != 0
      render json: {"questions"=>questions}
    else
      render json: {"message"=>"検索ワードを見つけられませんでした。"}
    end
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
