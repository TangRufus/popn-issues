module IssuesHelper
  def status_label(status)
    case status.downcase
    when 'uegent'
      key = 'danger'
    when 'closed'
      key = 'default'
    else
      key = 'info'
    end
    "<span class='label label-#{key}'>#{status.upcase}</span>".html_safe
  end
end
