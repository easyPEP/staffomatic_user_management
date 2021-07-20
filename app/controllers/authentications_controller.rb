class AuthenticationsController < ApplicationController
  skip_before_action :authorize!

  def create
    user = User.find_by(email: authentication_params[:email])

    if user && user.authenticate(authentication_params[:password])
      token = JwtAuthenticationService.encode_token({ user_id: user.id })
      render json: {
        user_id: user.id,
        user_email: user.email,
        token: token
      }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end

  private

  def authentication_params
    params.require(:authentication).permit(:email, :password)
  end
end
