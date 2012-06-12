module ApplicationHelper
  
  def post_date(date)
    return date.strftime("%A %B %d, %Y at %I:%M%p")
  end
  
  def short_date(date)
    return date.strftime("%D")
  end
  
  def dat_render(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true, :no_intra_emphasis => true)
    return markdown.render(text).html_safe
  end
  
end
