class SortController < ApplicationController
    def date_desc
        questions = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').order(created_at: "DESC")
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end
    end

    def date_asc
        questions = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').order(created_at: "ASC")
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end        
    end

    def like_desc
        questions = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').order(like_count: "DESC")
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end         
    end

    def like_asc
        questions = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').order(like_count: "ASC")
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end         
    end

    def solved
        questions = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').where(solved: true).order(created_at: "DESC")
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end         
    end

    def unsolved
        questions = Question.joins(:user, :like).select('questions.*, users.id as user_id, users.name as user_name, likes.count as like_count, likes.id as like_id').where(solved: false).order(created_at: "DESC")
        if questions
            render json: { "questions" => questions}
        else
            render json: { message: "質問を受け取れませんでした" }
        end         
    end
end
