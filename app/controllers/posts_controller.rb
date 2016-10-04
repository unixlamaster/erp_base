class PostsController < ApplicationController
  load_and_authorize_resource
  # GET /posts
  # GET /posts.json
  def index
    @d1 = params[:d1].nil? ? (Time.now - 3600*24*7).strftime("%F") : params[:d1]
    @d2 = params[:d2].nil? ? Time.now.strftime("%F") : params[:d2]
    @posts = Post.where("DATE(created_at) >= ? AND DATE(created_at) <= ?",@d1,@d2).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => COUNT_STRING_ON_PAGE, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @post.task_id = params[:task_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.staff_id = current_staff.id
    @post.staff_name = current_staff.lname + " " + current_staff.fname
    @post.wobj_name = @post.workobject.name
    @post.chif_name = @post.chif.lname + " " + @post.chif.fname

    respond_to do |format|
      if @post.save
        format.html { redirect_to params[:ref], notice: 'Post was successfully created.' }
        format.json { render json: params[:ref], status: :created, location: @post }
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
    @post.staff_id = current_staff.id

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
