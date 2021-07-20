class ApplicationController < ActionController::API
  before_action :authorize!

  private

  def current_user
    user_id = JwtAuthenticationService.decode_token(request)
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    !!current_user
  end

  def authorize!
    return true if logged_in?

    render json: { message: 'Please log in' }, status: :unauthorized
  end

  def render_jsonapi_internal_server_error(exception)
    puts(exception)
    super(exception)
  end
end
