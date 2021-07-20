require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create(
      email: 'danie@example.com',
      password: 'supersecurepassword',
      password_confirmation: 'supersecurepassword',
    )
  end

  describe 'GET /index' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      get users_path, headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:success)
    end
  end
end
