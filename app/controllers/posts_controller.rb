class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_blog, only: [:new, :create]

  load_and_authorize_resource :except => [:new, :create]

  # GET /blogs/:blog_id/posts/new
  def new
    authorize! :create_post_for, @blog
    @post = Post.new
    @post.blog = @blog
    @post.user = current_user
  end

  # GET /posts/:id/edit
  def edit
  end

  # POST /blogs/:blog_id/posts
  def create
    authorize! :create_post_for, @blog
    @post = Post.new(post_params)
    if @post.save
      redirect_to @blog, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      redirect_to @post.blog, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    blog = @post.blog
    @post.destroy
    redirect_to blog, notice: 'Post was successfully destroyed.'
  end

  private
    def set_blog
      @blog = Blog.find(params[:blog_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :can_be_commented, :comments_needs_approval, :blog_id, :user_id, :all_tags)
    end
end
