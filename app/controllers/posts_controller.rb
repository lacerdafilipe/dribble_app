class PostsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:upvote, :downvote]
  before_action :find_post, only: [:destroy, :show, :edit, :update, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @post = Post.all.order("created_at ASC")

  end

  def new
    @post = current_user.posts.build
  end

  def show
    @coments = Coment.where(post_id: @post)
    @random_post = Post.where.not(id: @post).order("RANDOM()").first
    @random_post2 = Post.where.not(id: @post).order("RANDOM()").second
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id
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

  def upvote
  		@post.upvote_by current_user
  		redirect_to @post
  end

  def downvote
  		@post.downvote_from current_user
  		redirect_to @post
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :link, :description, :image)
    end
end
