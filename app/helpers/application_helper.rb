module ApplicationHelper
  
  def post_date(date)
    date.strftime("%A %B %d, %Y at %I:%M%p")
  end
  
  def short_date(date)
    date.strftime("%D")
  end
  
  def dat_render(text)
    options = {
      :autolink => true,
      :space_after_headers => true,
      :no_intra_emphasis => true,
      :fenced_code_blocks => true,
      :hard_wrap  => true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end
  
end
