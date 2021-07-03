class Like < ApplicationRecord
    # optional trueしないとquestion投稿するときにエラーになる（関連先の値を検知しない） 
    belongs_to :question, optional: true

    # optional trueしないとanswer投稿するときにエラーになる（関連先の値を検知しない）
    belongs_to :answer, optional: true
end
