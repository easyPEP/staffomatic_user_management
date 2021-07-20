require 'rails_helper'

RSpec.describe "Signups", type: :request do
  describe "POST /create" do
    fit "returns http success" do
      user_data = {
        data: {
          attributes: {
            email: 'danni@example.com',
            password: 'supersecurepassword',
            password_confirmation: 'supersecurepassword'
          }
        }
      }
      expect {
        post '/signup', params: user_data.to_json, headers: { "Content-Type": "application/json" }
      }.to change(User, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    fit "returns http error" do
      user_data = {
        data: {
          attributes: {
            email: 'danni@example.com',
            password: 'supersecurepassword',
            password_confirmation: 'supersecurepassword!'
          }
        }
      }
      expect {
        post '/signup', params: user_data.to_json, headers: { "Content-Type": "application/json" }
      }.to change(User, :count).by(0)
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end
end
