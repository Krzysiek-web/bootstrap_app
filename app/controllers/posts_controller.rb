class PostsController < ApplicationController
  def new
    #author zapisany do sesji i automatycznie dodany przy kolejnym wpisie
    @post = Post.new(author: session[:author])
  end

  def create
    #post_params zdefiniowane poniżej w celu określenia jakie pola są brane pod uwagę - względy bezpieczeństwa
    @post = Post.new(post_params)
    @post.save
    session[:author] = @post.author
    flash[:notice] = "Post dodany pomyślnie"
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = "Post zaktualizowany pomyślnie."
    redirect_to posts_path
  end

  def index
    @posts = Post.all
    respond_to do |format|
      format.html {  }
      format.json{render json: @posts}
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :author, :body, :published)
  end
end
