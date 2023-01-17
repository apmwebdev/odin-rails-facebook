# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_like, only: :destroy

  def new
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)
    @like.user_id = current_user.id
    @like.turbo_target = get_turbo_target(@like)

    respond_to do |format|
      if @like.save
        format.turbo_stream
      end
    end
  end

  def destroy
    @like.turbo_target = get_turbo_target(@like)
    @like.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end

  def get_turbo_target(like)
    "#{like.likeable_type.downcase}_#{like.likeable_id}_likes"
  end
end
