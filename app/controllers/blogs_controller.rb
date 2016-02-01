class BlogsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource
  before_action :set_my_blog, only: [:myblog]


  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def myblog
    if @blog
      redirect_to edit_blog_path(@blog.id)
    else
      raise CanCan::AccessDenied.new("Not authorized!", :create, Blog)
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def set_my_blog
      if current_user
	@blog = current_user.blog
        unless @blog
          @blog = Blog.new
          @blog.save
        end
      else
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:name)
    end
end
