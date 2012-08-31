class Post
  
  include MongoMapper::Document
  
# many :comments
  
  key :body, String, required: true
  key :title, String, required: true
  key :published, Boolean, default: false
  key :slug, String
  key :description, String
  
  timestamps!
  
  attr_accessible :body, :title, :published, :description
  
  ensure_index :slug

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def to_param
    "#{self.slug}"
  end
  
  def to_indexed_json
    self.as_json
  end

  def self.search(params)
    tire.search(load: true) do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
      sort { by :created_at, "desc" } if params[:query].blank?
    end
  end
end
