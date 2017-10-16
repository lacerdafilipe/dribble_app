class ComentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @coment = Coment.create(params[:coment].permit(:content))
    @coment.user_id = current_user.id
    @coment.post_id = @post.id

    if @coment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

end
