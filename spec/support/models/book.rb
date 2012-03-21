class Book
  include Mongoid::Document
  include Mongoid::Genesis

  field :author
  field :title
  field :url

  attr_accessible :author, :title, :url
end
