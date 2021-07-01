class Like < ApplicationRecord
    # optional trueしないとquestion投稿するときにエラーになる（関連先の値を検知しない） 
    belongs_to :question, optional: true
end
