# -*- encoding : utf-8 -*-
class StoragesController < ApplicationController
load_and_authorize_resource
include StoragesHelper
include ApplicationHelper

# GET /storage
# GET /storage.json
  def index
    @storages =  params[:address].nil? ?  Storage : Storage.where(address: params[:address])
    @storages = @storages.search(params[:search]).order(sort_column + " " + sort_direction + ",id asc").paginate(:per_page => COUNT_STRING_ON_PAGE, :page => params[:page])
	  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @storage }
    end
  end
 # GET /storage/1
 # GET /storage/1.json
  def show
    @storage = Storage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @storage }
      end
    end  
 # GET /storage/new
 # GET /storage/new.json
  def new
    @storage = Storage.new(params[:storage])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @storage }
    end
  end
  # GET /storage/1/edit
  def edit
    @storage = Storage.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @storage }
    end
  end
  # POST /storage
  # POST /storage.json
  def create
    @storage = Storage.new(params[:storage])

    respond_to do |format|
      if @storage.save
       format.html { redirect_to storages_path, notice: 'Storage post was successfully created.'}
       format.json { render json: @storage, status: :created, location: @storage }
          else
          format.html { render action: "new" }
          format.json { render json: @storage.errors, status: :unprocessable_entity }
          end
       end
     end
 # PUT /storage/1
 # PUT /storage/1.json
  def update
    @storage = Storage.find(params[:id])

    respond_to do |format|
      if @storage.update_attributes(params[:storage])
        format.html { redirect_to storages_path, notice: 'Storage post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end
 # DELETE /storage/1
 # DELETE /storage/1.json
  def destroy
    @storage = Storage.find(params[:id])
    if current_staff.admin?
      @storage.destroy
    end
      respond_to do |format|
        format.html { redirect_to storage_url }
        format.json { head :no_content }
     end
   end
end
