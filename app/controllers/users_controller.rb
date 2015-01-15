class UsersController < ApplicationController

  before_action :authenticated!, :authorized!, except: [:new, :create]

  def new
    @user = User.new
    @categories = ["Inspiration", "Business", "Sports", "Life", "Funny", "Love"]
  end

  def create
    @user = User.new(phone: params[:user][:phone], password: params[:user][:password_digest], password_confirmation: params[:user][:password_digest])

    category = params[:user][:category].downcase

    if category == "business"
      category = "management"
    elsif category == "inspiration"
      category = "inspire"
    end

    @user.category = category

    if @user.save
      session[:user_id] = @user.id
      @user.send_message("Thanks for signing up for Quotable! You'll receive a quote at 10am CT every day, but here's one to start off with:", false)
      quote = Quote.find_by(category: @user.category)
      @user.send_message(quote)
      redirect_to edit_user_path(@user)
    else
      @message = "Invalid! Try again. If you already have an account, click Login."
      @user = User.new
      @categories = ["Inspiration", "Business", "Sports", "Life", "Funny", "Love"]
      render 'users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @categories = ["Inspiration", "Business", "Sports", "Life", "Funny", "Love"]
    @category = @user.category.capitalize
    if @category == "Inspire"
      @category = "Inspiration"
    elsif @category == "Management"
      @category = "Business"
    end
  end

  def update
    @user = User.find(params[:id])
    category = params[:user][:category].downcase

    if category == "business"
      category = "management"
    elsif category == "inspiration"
      category = "inspire"
    end

    @user.category = category

    @user.save
    redirect_to edit_user_path(@user)
  end

  def disable
    @user = User.find(params[:id])
    @user.texting = (@user.texting ? false : true)
    @user.save
    redirect_to edit_user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorized!
    @user = User.find(params[:id])
    unless @user.id == session[:user_id]
      redirect_to edit_user_path(session[:user_id])
    end
  end

end