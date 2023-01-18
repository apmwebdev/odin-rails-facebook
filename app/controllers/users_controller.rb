# frozen_string_literal: true
require "faker"

class UsersController < ApplicationController
  before_action only: [:new, :create, :create_in_bulk] do
    redirect_to :not_found unless current_user&.admin
  end
  before_action :set_user, only: %i[ show ]
  def index
    @users = User.all
  end

  def show
    @profile = @user.user_profile
  end

  def new
    @user = User.new
  end

  def create
    verified_params = user_params
    @user = User.new(
      first_name: verified_params[:first_name],
      last_name: verified_params[:last_name],
      email: verified_params[:email],
      admin: verified_params[:admin],
      password: "test12"
    )

    if @user.save
      redirect_to @user, notice: "User created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def create_in_bulk
  end

  def do_create_in_bulk
    num = params[:number_to_create].to_i
    num.times { generate_user }
    redirect_to users_path, notice: "Users created successfully"
  end

  def profile
    @user = current_user
    @profile = current_user.user_profile
    render :show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :admin)
  end

  def generate_user
    email = Faker::Internet.email
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    password = Devise.friendly_token.first(8)
    gen_user = User.new(email:, first_name:, last_name:, password:)
    gen_user.save
  end
end
