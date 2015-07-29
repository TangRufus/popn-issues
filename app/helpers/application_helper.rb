module ApplicationHelper
  def markdownify(content)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::BootstrapResponsiveImageFilter,
      HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::AutolinkFilter,
      HTML::Pipeline::SanitizationFilter
      ], pipeline_context
      pipeline.call(content)[:output].to_s.html_safe
  end

  def pipeline_context
    {
      gfm: true,
      asset_root: 'https://a248.e.akamai.net/assets.github.com/images/icons/',
      whitelist: pipeline_whitelist
    }
  end

  def pipeline_whitelist
    Sanitize::Config.merge(
      HTML::Pipeline::SanitizationFilter::WHITELIST,
      attributes: {
        'img' => HTML::Pipeline::SanitizationFilter::WHITELIST[:attributes]['img'] << 'class'
      }
    )
  end

  def bootstrap_context(key)
    case key
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
