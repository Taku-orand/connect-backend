class RequestsController < ApplicationController
    def index
        requests = Request.all.order(created_at: "DESC")

        if requests
            render json: { "requests" => requests }
        else
            render json: { message: "feedbackを取得できません" }
        end
    end

    def show
        request_id = params[:id]
        request = Request.find(request_id)
        
        if request
            render json: { request: request }
        else
            render json: { message: "feedbackを取得できません" }
        end
    end 

    def create
        details = receiveBody
        request = details[:request]
        user = User.find(current_user.id)
        target = user.requests.new(request)

        begin
            target.save!
            render json: { created_request: true }
        rescue ActiveRecord::RecordInvalid => e
            puts e
            render json: {created_request: false}
        end
    end

    private
    def receiveBody
        JSON.parse(request.body.read, {:symbolize_names => true})
    end
end
