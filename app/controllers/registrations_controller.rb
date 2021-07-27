class RegistrationsController < ApplicationController
  # サインアップ処理
  def signup
    @user = User.new(registrations_params)

    if @user.save
      signin! #セッションにユーザー情報を置く
      render json: { status: :created, signed_up: true, user: @user }
    else
      render json: {
        status: 500, signed_up: false,
        errors: @user.errors.keys.map { |key| [key, @user.errors.full_messages_for(key)]}.to_h
      }
    end
  end

  private
  def registrations_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end 
end
