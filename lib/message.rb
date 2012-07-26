class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :message, :spamtrap

  validates :name, :email, :message, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true
  validates :spamtrap, :format => {:with => /blue/, :message => "Go away until you know the answer"}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end
