# frozen_string_literal: true

class PostsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_post, except: %i[index new create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post saved successfully.'
        format.html { redirect_to post_path(@post) }
      else
        flash[:alert] = 'Could not create post.'
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to post_path(@post) }
      else
        flash[:alert] = 'Could not update post.'
        render :edit
      end
    end
  end

  def destroy
    respond_to do |format|
      flash[:notice] = 'Post was successfully deleted.'
      format.html { redirect_to posts_path }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
