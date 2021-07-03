class SortController < ApplicationController
    def date_desc
        questions = Question.all.order(created_at: :desc)
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end
    end

    def date_asc
        questions = Question.all.order(created_at: :asc)
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end        
    end

    def like_desc
        questions = Question.all.order(like: :desc)
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end         
    end

    def like_asc
        questions = Question.all.order(like: :asc)
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end         
    end

    def solved
        questions = Question.where(solved: '1')
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end         
    end

    def unsolved
        questions = Question.where(solved: '0')
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end         
    end
end
