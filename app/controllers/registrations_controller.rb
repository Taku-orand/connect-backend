class RegistrationsController < ApplicationController
  def signup
    @user = User.new(registrations_params)

    if @user.save
      signin!
      render json: { status: :created, signed_up: true, user: @user }
    else
      render json: { status: 500, signed_up: false }
    end
  end

  private

  def registrations_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end 
end
