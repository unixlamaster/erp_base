# -*- encoding : utf-8 -*-
module ApplicationHelper
 
  def current_user
    current_user = current_staff
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column() ? "current #{sort_direction}" : nil
    direction = column == sort_column() && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

    def sort_column
      params[:sort].nil? ? "id" : params[:sort]
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
