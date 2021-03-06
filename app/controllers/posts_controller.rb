class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: :destroy

  def index
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "削除しました"
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :picture)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to posts_url if @post.nil?
    end
end
