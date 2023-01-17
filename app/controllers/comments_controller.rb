# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ edit update destroy ]

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.commenter_id = current_user.id
    @comment.turbo_target = "post_#{@comment.commentable_id}_comments"

    respond_to do |format|
      if @comment.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy

  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end
