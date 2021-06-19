class SessionsController < ApplicationController
  def signin
    @user = User.find_by(email: session_params[:email])

    if @user && @user.authenticate(session_params[:password])
      signin!
      render json: { signed_in: true, user: @user }
    else
      render json: { status: 401, errors: ['認証に失敗しました。', '正しいメールアドレス・パスワードを入力し直すか、新規登録を行ってください。'] }
    end
  end

def signout
  reset_session
  render json: { status: 200, signed_out: true }
end

def signed_in?
  if current_user
    render json: { signed_in: true, user: current_user }
  else
    render json: { signed_in: false, message: 'ユーザーが存在しません' }
  end
end

private

  def session_params
    params.require(:user).permit(:username, :email, :password)
  end
end
