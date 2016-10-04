class TaskDelegatesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  load_and_authorize_resource
  include WorkobjectsHelper
  include SendSmsHelper


  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @task_delegate = TaskDelegate.new(params[:task_delegate])
    @task_delegate.when_date = Time.now.getlocal
    respond_to do |format|
      if @task_delegate.save
        @task = Task.find(@task_delegate.task_id)
        @task.update_attributes(:staff_id => params[:task_delegate]["staff_to"], :state => '3new')
        Mailer.task_notification(Staff.find(params[:task_delegate]["staff_to"]),Staff.find(current_staff.id),@task).deliver
        sms_state = send_sms(Staff.find(@task_delegate.staff_to),Staff.find(@task_delegate.staff_from),@task.id) =~ /100/ ? "SMS send Ok" : "SMS not send"
        format.html { redirect_to @task, notice: 'Task was successfully created.<br>'+sms_state }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
  end

end

