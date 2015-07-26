module IssuesHelper
  def status_label(status)
    "<span class='label label-#{status_color_class(status)}'>#{status.titleize}</span>".html_safe
  end

  def status_color_class(status)
    case status.downcase
    when 'uegent'
      key = 'danger'
    when 'closed'
      key = 'default'
    else
      key = 'info'
    end
  end
end
