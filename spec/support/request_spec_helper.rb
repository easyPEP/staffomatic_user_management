module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def authenticate_user(user)
    auth_params = { authentication: {
      email: user.email,
      password: 'supersecurepassword'
    }}
    post '/authentications', params: auth_params.to_json, headers: { "Content-Type": "application/json" }
    return json['token']
  end
end
