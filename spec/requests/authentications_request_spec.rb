require 'rails_helper'

RSpec.describe "Authentications", type: :request do

  let(:user){
    User.create(
      email: 'danie@example.com',
      password: 'supersecurepassword',
      password_confirmation: 'supersecurepassword',
    )
  }

  describe "POST Authentications#create" do
    it 'create JWT tokens for user' do
      auth_params = { authentication: {
        email: user.email,
        password: 'supersecurepassword'
      }}
      post '/authentications', params: auth_params.to_json, headers: { "Content-Type": "application/json" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(201)
    end

    it 'should return errors for invalid auth params' do
      auth_params = { authentication: {
        email: user.email,
        password: 'supersecurepassword!!'
      }}
      post '/authentications', params: auth_params.to_json, headers: { "Content-Type": "application/json" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
    end
  end
end
