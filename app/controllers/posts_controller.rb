class PostsController < ApplicationController
  def index
    @post = Post.all.order
  end

  def new
    @post = Post.new
  end

  private
    def permit
    end
end
