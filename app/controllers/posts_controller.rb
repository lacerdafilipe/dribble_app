class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @post = Post.all.order("created_at ASC")
  end

  def new
    @post = current_user.posts.build
  end

  def show
    @coments = Coment.where(post_id: @post)
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
      if @post.update(post_params)

        redirect_to @post
      else
        render 'edit'
      end
  end

  def destroy
    @post.destroy

    redirect_to root_path
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :link, :description, :image)
    end
end
