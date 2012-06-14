xml.instruct! :xml
xml.xml :version => "1.0" do
  xml.rss :version => "2.0" do
    xml.channel do
      xml.title "JohnnyGrubb.com"
      xml.description "Grubblog"
      xml.link posts_url
    
      for post in @posts
        xml.item do
          xml.title post.title
          xml.description dat_render(post.body)
          xml.pubDate post.created_at.to_s(:rfc822)
          xml.link post_url(post)
          xml.guid post_url(post)
        end
      end
    end
  end
end