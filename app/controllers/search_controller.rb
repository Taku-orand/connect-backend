class SearchController < ApplicationController
  #文字列検索
  def searchByWord
    word = params[:word]
    questions = Question.where('title like ? OR content like ?', "%#{word}%", "%#{word}%").order(created_at: "DESC")
    if questions.length > 0
      render json: {"questions"=>questions, "searched_by_word"=>true}
    else
      render json: {"searched_by_word"=>false}
    end
  end

  #タグ検索
  def searchByTag
    #/tags/2/search の場合、id２のタグ取得
    tag = Tag.find(params[:id]) 
    #tagに関連するquestionを全取得
    questions = tag.questions.all
    if questions.length > 0
      render json: {"questions" => questions, "searched_by_tag" => true}
    else
      render json: {"searched_by_tag" => false}
    end
  end
end
