class UsersController < ApplicationController

  def show
    @user = params[:user_name]
    if params[:sort] ==  nil
      @user_reviews = Review.where(user: @user)
    elsif params[:sort] == "newest"
      @user_reviews = Review.where(user: @user).order("created_at desc")
    else params[:sort] == "oldest"
      @user_reviews = Review.where(user: @user).order("created_at asc")
    end
  end
end
