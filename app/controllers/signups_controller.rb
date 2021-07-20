class SignupsController < ApplicationController
  include JSONAPI::Errors
  include JSONAPI::Deserialization
  skip_before_action :authorize!

  def create
    user = User.new(jsonapi_deserialize(params, only: signup_params))
    if user.save
      render jsonapi: user, status: :created
    else
      render jsonapi_errors: user.errors, status: :unprocessable_entity
    end
  end

  private

  def signup_params
    %i[email password password_confirmation]
  end
end
