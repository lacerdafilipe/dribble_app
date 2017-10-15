class ComentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:create]

  def create
    @coment = Coment.create(params[:coment].permit(:content))
    @coment.user_id = current_user.id
    @coment.post_id = @post.id

    if @coment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  private
    def find_post
      @post = Post.find(params[:post_id])
    end
end
