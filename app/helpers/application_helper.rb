module ApplicationHelper
  
  def post_date(date)
    return date.strftime("%A %B %d, %Y at %I:%M%p")
  end
  
  def short_date(date)
    return date.strftime("%D")
  end
  
end
