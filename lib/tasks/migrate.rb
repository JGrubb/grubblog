require 'sequel'
require 'date'

DB = Sequel.connect(
  :adapter  => 'mysql',
  :host     => 'localhost',
  :user     => 'root',
  :password => 'root',
  :database => 'ibd'
)

DB2 = Sequel.connect(
  :adapter  => 'mysql',
  :host     => 'localhost',
  :user     => 'root',
  :password => 'root',
  :database => 'blog_development'
)

DB3 = Sequel.connect(
  :adapter  => 'mysql',
  :host     => 'localhost',
  :user     => 'root',
  :password => 'root',
  :database => 'blog_production'
)

node = DB[:node]
revisions = node.join(:node_revisions, :vid => :vid).where(:type => 'blog')
slugs = DB[:url_alias].where(:src.like('node%'))
posts = DB2[:posts]
new_posts = DB3[:posts]

DB2[:users].insert(DB3[:users].first)

new_posts.each do |post|
  DB2[:posts].insert(:id => post[:id], :title => post[:title], :body => post[:body], :created_at => post[:created_at], :updated_at => post[:updated_at], :slug => post[:slug], :published => post[:published])
  #puts post[:updated_at]
end

File.open('migrate.csv', 'w') do |f|
  revisions.each do |item|
    created_at = Time.at(item[:created]).to_datetime
    updated_at = Time.at(item[:changed]).to_datetime
    title = item[:title]
    id = item[:nid]
    body = item[:body]
    published = item[:status]
    slug = slugs.first(:src => "node/#{id}")
    #puts "#{title} - #{slug[:dst]}"
    #puts item
    posts.insert(:id => "#{id.to_i + 20}", :title => title, :body => body, :published => published, :slug => slug[:dst][8..-1], :created_at => created_at, :updated_at => updated_at)
    if slug[:dst][8..-1]
      DB2[:friendly_id_slugs].insert(:slug => slug[:dst][8..-1], :sluggable_id => "#{id.to_i + 20}", :sluggable_type => 'Post', :created_at => Time.now)
    end
    f.puts "http://ignoredbydinosaurs.com/#{slug[:dst]}, http://www.johnnygrubb.com/posts/#{slug[:dst][8..-1]}"
  end
end