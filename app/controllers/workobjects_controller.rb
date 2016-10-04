class WorkobjectsController < ApplicationController
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource
  include ApplicationHelper

  # GET /workobjects
  # GET /workobjects.json
  def index
    @workobjects = Workobject.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => COUNT_STRING_ON_PAGE, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workobjects }
    end
  end

  # GET /workobjects/1
  # GET /workobjects/1.json
  def show
    @workobject = Workobject.find(params[:id])
    @wo_tasks = Task.where(workobject_id: params[:id])
    @wo_staff = Staffobjectjournal.where(workobject_id: params[:id])
    @wo_post = Post.where(workobject_id: params[:id])
    @wo_upload = Upload.where(workobject_id: params[:id])
    @date_po_up = DatePostsUploads.where(workobject_id: params[:id])
    @finances = FinanceWoStaff.where(wo_id: params[:id]).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 15)
    @fin_wo_sum = FinanceWoStaff.where(wo_id: params[:id]).sum('summa').round

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workobject }
    end
  end

  # GET /workobjects/new
  # GET /workobjects/new.json
  def new
    @workobject = Workobject.new
    @workobject.latitude = params[:latitude]
    @workobject.longtitude = params[:longtitude]
    @contracts = Contract.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workobject }
    end
  end

  # GET /workobjects/1/edit
  def edit
    @workobject = Workobject.find(params[:id])
    @contracts = Contract.all
  end

  # POST /workobjects
  # POST /workobjects.json
  def create
    @workobject = Workobject.new(params[:workobject])

    respond_to do |format|
      if @workobject.save
        format.html { redirect_to @workobject, notice: 'Workobject was successfully created.' }
        format.json { render json: @workobject, status: :created, location: @workobject }
      else
        format.html { render action: "new" }
        format.json { render json: @workobject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workobjects/1
  # PUT /workobjects/1.json
  def update
    @workobject = Workobject.find(params[:id])

    respond_to do |format|
      if @workobject.update_attributes(params[:workobject])
        format.html { redirect_to @workobject, notice: 'Workobject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workobject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workobjects/1
  # DELETE /workobjects/1.json
  def destroy
    @workobject = Workobject.find(params[:id])
    @workobject.destroy

    respond_to do |format|
      format.html { redirect_to workobjects_url }
      format.json { head :no_content }
    end
  end

end
