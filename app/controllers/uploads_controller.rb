# -*- encoding : utf-8 -*-
class UploadsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  load_and_authorize_resource

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = case params[:flag]
               when "wo"
                 @src = "для объекта "+Workobject.find(params[:upload][:workobject_id]).fulladdr
                 @param = {:flag=>"wo","upload[workobject_id]"=>params[:upload][:workobject_id]}
                 Upload.where(workobject_id: params[:upload][:workobject_id])
               when "ts"
                 @src = "задачи "+Task.find(params[:upload][:task_id]).description
                 @param = {:flag=>"ts","upload[task_id]"=>params[:upload][:task_id]}
                 Upload.where(task_id: params[:upload][:task_id])
               when "co"
                 @src = "к контракту "+Contract.find(params[:upload][:contract_id]).name
                 @param = {:flag=>"co","upload[contract_id]"=>params[:upload][:contract_id]}
                 Upload.where(contract_id: params[:upload][:contract_id])
               else
                 Upload.all
               end
#    @upload = Upload.new(params[:upload])
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploads }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @upload = Upload.find(params[:id])
    directory = "uploads/#{@upload.workobject_id}"
    directory = "uploads_task/#{@upload.task_id}" unless @upload.task_id.nil?
    directory = "uploads_contract/#{@upload.contract_id}" unless @upload.contract_id.nil?
    path = File.join(directory, @upload.filename)
    send_file path, :type => "Content-Type", :disposition => 'attachment; filename='+@upload.filename

#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @upload }
#    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
    @upload = Upload.new(params[:upload])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  def create
     #  @upload = Upload.new(params[upload])
     # POST /uploads
     # POST /uploads.json
    upld = Upload.new
    upld.save_upload(params[:upload][:filename],params[:upload],current_staff.id,params[:flag])
    respond_to do |format|
      format.html { redirect_to params[:ref], notice: 'Upload was successfully created.' }
#action: 'index', status: 303 
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private
    def record_not_found
      respond_to do |format|
        format.html { redirect_to "/contracts", notice: 'Record not found!!!' }
      end
    end

end
