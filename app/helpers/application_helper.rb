module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    #css_element_id = column == sort_column
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
end