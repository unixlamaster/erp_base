# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_staff!
  include ApplicationHelper

rescue_from CanCan::AccessDenied do |exception|
    flash[:alert]="Доступ запрещен !!!"
    render :template => "errors/accessdenied" 
#    render :template => "errors/accessdenied", flash[:alert]=exception.message
#    redirect_to root_url, :alert => exception.message
end

protected
end
