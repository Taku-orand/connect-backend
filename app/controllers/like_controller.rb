class LikeController < ApplicationController
    # like数を増やす処理
    def add
        like_id = params[:id]
        target = Like.find_by(id: like_id)
        target.count += 1

        begin
            target.save!
            render json: {add_like: true, like_count: target.count}
        rescue ActiveRecord::RecordInvalid => exception
            puts exception
        end
    end
end
