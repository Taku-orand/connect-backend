class ApplicationController < ActionController::API
  include ActionController::Helpers

  skip_before_action :verify_authenticity_token, raise: false

  helper_method :signin!, :current_user

  def signin!
    session[:user_id] = @user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = User.find(0) 
    end
  end
end
