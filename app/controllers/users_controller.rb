class UsersController < ApplicationController

  def show
    @user = params[:user_name]
    @user_reviews = Review.where(user: @user)
  end
end
