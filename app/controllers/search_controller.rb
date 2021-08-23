class SearchController < ApplicationController
  #文字列検索
  def searchByWord
    word = params[:word]
    words = word.split(/[[:blank:]]+/)
    questions = []

    words.each do |word|
      questions += Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').where('title LIKE ? OR content LIKE ?', "%#{word}%", "%#{word}%").order(created_at: "DESC")
    end

    if questions
      render json: {"questions"=>questions, "searched_by_word"=>true}
    else
      render json: {"searched_by_word"=>false}
    end
  end

  #タグ検索
  def searchByTag
    tag = Tag.find(params[:id]) 
    #tagに関連するquestionを全取得し、作成日降順で返す
    questions = tag.questions.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').all.order(created_at: "DESC")
    if questions.length > 0
      render json: {"questions" => questions, "get_question" => true}
    else
      render json: {"get_question" => false}
    end
  end
end
