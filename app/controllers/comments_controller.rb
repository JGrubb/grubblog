class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if @post.comments.create(params[:comment])
      redirect_to post_path(@post)
    else
      flash[:error] = 'Something went wrong. Try it again.'
      redirect_to post_path(@post)
    end
  end
end
