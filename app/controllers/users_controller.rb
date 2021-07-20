class UsersController < ApplicationController
  def index
    render jsonapi: User.all
  end
end
