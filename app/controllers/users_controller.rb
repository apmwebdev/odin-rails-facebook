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
  end

  def new
    @user = User.new
  end

  def create
    generated_password = Devise.friendly_token.first(8)
    @user = User.new(user_params)
    @user.encrypted_password = generated_password

    if @user.save
      redirect_to @user, notice: "User created successfully"
    end
  end

  def create_in_bulk
  end

  def do_create_in_bulk
    num = params[:number_to_create].to_i
    num.times { generate_user }
    redirect_to users_path, notice: "Users created successfully"
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
