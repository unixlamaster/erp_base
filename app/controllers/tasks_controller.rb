# -*- encoding : utf-8 -*-
class TasksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  load_and_authorize_resource
  include WorkobjectsHelper
  include ApplicationHelper
  include SendSmsHelper
  helper_method :sort_column, :sort_direction


  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = if (current_staff.is? :admin) && params[:state]=='all'
               Task
        else
          case( params[:state])
              when /1end|2run|3new/
                Task.where(state: params[:state],staff_id: current_staff.id)
              when /delegate/
                Task.where("staff_from_id=? and staff_id!=?",current_staff.id,current_staff.id)
              else
                Task.where(state: "3new",staff_id: current_staff.id)
          end
        end
    @tasks = @tasks.search(params[:search]).order(sort_column + " " + sort_direction + ",priority desc").paginate(:per_page => COUNT_STRING_ON_PAGE, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @task.update_attribute(:state, "2run") if @task.state=="3new" && current_staff.id==@task.staff_id
    @task_history = TaskDelegate.where(task_id: @task.id)
    @task_delegate = TaskDelegate.new(task_id: @task.id, staff_from: current_staff.id)
    @staff_from_fullname = Staff.exists?(@task.staff_from_id) ? Staff.find(@task.staff_from_id).fullname : ""
    @wo_fulladdr =  @task.workobject_id.nil? ?  "" : Workobject.find(@task.workobject_id).fulladdr
    @post = Post.new
    @upload = Upload.new

    @task_posts = Post.where(task_id: params[:id])
    @task_uploads = Upload.where(task_id: params[:id])
    @date_po_up = DatePostsUploads.where(task_id: params[:id])


      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
      end
    end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new(sdate:Time.now.getlocal.strftime("%F"),edate:Time.now.getlocal.strftime("%F"))
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
   if current_staff.id==@task.staff_id
  end
end
  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.staff_from_id = current_staff.id
    @task.state = "3new"
    if @task.sdate.nil? || params[:task][:sdate].empty?
      @task.sdate = Time.now.getlocal unless @task.period.nil? || @task.period.empty? 
    end

    respond_to do |format|
      if @task.save
        task_delegate = TaskDelegate.new
        task_delegate.staff_from = current_staff.id
        task_delegate.staff_to = params[:task]["staff_id"]
        task_delegate.task_id = @task.id
        task_delegate.when_date = Time.now.getlocal
        if task_delegate.save
          Mailer.task_notification(Staff.find(params[:task]["staff_id"]),Staff.find(current_staff.id),@task).deliver
          sms_state = send_sms(@task)
          format.html { redirect_to @task, notice: "Task was successfully created.<br>SMS status=#{sms_state}".html_safe }
          format.json { render json: @task, status: :created, location: @task }
        else
          format.html { render action: "new" }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
#    @task.staff_from_id = current_staff.id
    old_staff_id = @task.staff_id.nil? ? 0 : @task.staff_id

    respond_to do |format|
      if @task.update_attributes(params[:task])
        if params[:task][:sdate].empty?
          begin
            @task.sdate = Time.now.getlocal
            @task.save
          end   unless @task.period.nil? || @task.period.empty?
        end

        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

#+++++++++++++++++++++++++++++++++++++++
  def change
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(params[:task])
        if @task.status=='1end'
          Mailer.task_end_notification(@task).deliver
          sms_state = send_sms(@taskd)
        end
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.js
      else
        format.html { redirect_to @task, notice: 'Задача не обновилась !!!' }
        format.js
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    if current_staff.admin?
      @task.destroy
    end
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end


      private
        def record_not_found
         write_attribute(:description," ")
         write_attribute(:workobject_id,0)
       end

end

