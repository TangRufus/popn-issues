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

  private

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
end
