class PostsController < ApplicationController
  
  include ActionView::Helpers::TextHelper
  
  before_filter :require_user, :only => [:new, :create, :update, :destroy, :unpublished]
  # GET /posts
  # GET /posts.json
  # caches_page :index
  def index
    @posts = Post.order("created_at DESC").where(:published => true).limit(5)
    @title = "Home"
    @description = "the blog and website of bassist and programmer Johnny Grubb.  no baseball information here."
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
      format.xml
    end
  end
  
  def sitemap
    @posts = Post.where(:published => true).all
    respond_to do |format|
      format.xml
    end
  end
  
  def feed
    @posts = Post.order("created_at DESC").where(:published => true).limit(20)
    respond_to do |format|
      format.xml
      format.rss { render :layout => false }
      format.json { render :json => @posts}
    end
  end
  
  def all
    @posts = Post.order("created_at DESC").where(:published => true)
    @title = "All posts"
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end
  
  def unpublished
    @posts = Post.order("created_at DESC").where(:published => false)
    
    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @posts }
      format.xml
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find_by_slug(params[:id])
    @title = @post.title
    @description = @post.description ? @post.description : truncate(@post.body, :length => 250)
    if request.path != post_path(@post)
      return redirect_to @post, :status => :moved_permanently
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @title = "New post"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @title = "Editing #{@post.title}"
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
