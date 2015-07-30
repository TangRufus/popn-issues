module ApplicationHelper
  def bootstrap_context(key)
    case key.downcase
    when 'danger', 'error', 'alert', 'urgent'
      'danger'
    when 'warning'
      'warning'
    when 'success'
      'success'
    when 'default', 'closed'
      key = 'default'
    else
      'info'
    end
  end

  def toastr_context(key)
    b_key = bootstrap_context(key)
    case b_key
    when 'danger'
      'error'
    when 'default'
      'info'
    else
      b_key
    end
  end
end
