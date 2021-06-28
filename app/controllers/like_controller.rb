class LikeController < ApplicationController
    def add
        like_id = params[:id]
        target = Like.find_by(id: like_id)
        target.count += 1

        begin
            target.save!
            render json: {add_like: true}
        rescue ActiveRecord::RecordInvalid => exception
            puts exception
        end
    end
end
