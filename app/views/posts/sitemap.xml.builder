xml.instruct! :xml
xml.urlset :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  for post in @posts
    xml.url do
      xml.loc post_url(post)
      xml.lastmod post.updated_at.strftime("%Y-%m-%d")
      xml.changefreq "monthly"
      xml.priority "0.5"
    end
  end
end