# -*- encoding : utf-8 -*-
class StaffsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  load_and_authorize_resource
  include ApplicationHelper
  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = if params[:notwork]=='no'
                Staff.where(status: 'Работает')
              else
                Staff
              end
      
    @staffs = @staffs.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => COUNT_STRING_ON_PAGE)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @staffs }
    end
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    @staff = Staff.find(params[:id])
    @staff_tasks = StaffTaskJournal.where(staff_id: params[:id])
    @staff_objects = Staffobjectjournal.where(staff_id: params[:id])
    @finances = Finance.where(staff_id: params[:id]).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 15)
    @fin_wo_sum = Finance.where(staff_id: params[:id]).sum('summa').round


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @staff }
    end
  end

  # GET /staffs/new
  # GET /staffs/new.json
  def new
    @staff = Staff.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @staff }
    end
  end

  # GET /staffs/1/edit
  def edit
    @staff = Staff.find(params[:id])
  end

  def edit_password
    raise CanCan::AccessDenied unless current_staff.id==params[:id]
    @staff = Staff.find(params[:id])
    render "edit_password"
  end

  def update_password
    @staff = Staff.find(params[:staff][:id])
    respond_to do |format|
      if @staff.update_attributes(params[:staff])
        # Sign in the user by passing validation in case his password changed
#        sign_in @staff, :bypass => true
        format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
      else
        format.html { render action: "edit_password" }
      end
    end
  end



  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(params[:staff])

    respond_to do |format|
      if @staff.save
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render json: @staff, status: :created, location: @staff }
      else
        format.html { render action: "new" }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /staffs/1
  # PUT /staffs/1.json
  def update
    @staff = Staff.find(params[:id])

    respond_to do |format|
      if @staff.update_without_password(params[:staff])
        format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff = Staff.find(params[:id])
    @staff.destroy

    respond_to do |format|
      format.html { redirect_to staffs_url }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:staff).permit(:password, :password_confirmation)
  end

    def record_not_found
#:birthday, :fname, :lname, :mname, :passport, :position, :skill, :login, :password, :email, :phone1, :phone2
#      write_attribute(:fname," ")
#      write_attribute(:mname," ")
#      write_attribute(:lname," ")
#      write_attribute(:login," ")
  end

end
