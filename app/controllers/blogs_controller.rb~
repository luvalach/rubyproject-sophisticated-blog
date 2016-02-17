class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :set_default_theme, only: [:index]

  load_and_authorize_resource :except => [:myblog, :editmyblog]

  # GET /blogs
  # GET /blogs.json
  def index
    params.delete_if { |k, v| v.blank? } # empty search fields should be ignored

    @params = params # propagate settings back to view
    
    unless current_user and current_user.has_role? :admin and params[:search_show_unpublish] == 'on' 
      params[:search_only_published] = true 
    end
    
    conditions = ['1=1'] # at least one condition must exists
    conditions << "name like :search_name" if params[:search_name] 
    conditions << "description like :search_description" if params[:search_description]
    conditions << "publish = :search_only_published" if params[:search_only_published]  
    
    @blogs = Blog.where(conditions.join(' AND '), params).paginate(:page => params[:page], :per_page => 5).order('name ASC')
    print current_user.has_role? :admin unless current_user.nil?
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    # @blog.posts.map { |p| p.new_comment = Comment.build_from(p, current_user.id, "") }
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

  # GET /myblog
  def myblog
     redirect_to blog_path(current_user.blog.id)
  end

  # GET /myblogsettings
  def editmyblog
     redirect_to edit_blog_path(current_user.blog.id)
  end

  # GET /new_post_on_my_blog
  def new_post_on_my_blog
     session[:theme] = current_user.blog.theme
     redirect_to new_blog_post_path(current_user.blog.id)
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
      session[:theme] = @blog.theme
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:name, :description, :publish, :commentable, :comment_needs_approval, :theme)
    end

    def set_default_theme
      session[:theme] = 'slate'
    end
end
