Mongoid Genesis
===============

Mongoid Genesis will give you the ability to override data in your model
without losing the initial data.

Install
-------

```
gem install mongoid_genesis
```

Rails 3
-------

In your Gemfile:

```ruby
gem 'mongoid_genesis'
```

Usage
-----

Mongoid Genesis is compatible with any mongoid collection or embedded object.


**Model integration**

```ruby
class Book
  include Mongoid::Document
  include Mongoid::Genesis
end
```

This will create an embedded object that will store the original data.

**Basic manipulation**

```ruby
book = Book.new(:title => 'Art of war', :author => 'Sun Tzu', :country => 'China')
#=> #<Book _id: 4f68d82f9421794f48000001, title: "Art of war", author: "Sun Tzu", _type: nil, country: "China">

book.genesis
#=> #<BookGenesis _id: 4f68d82f9421794f48000002, _type: nil >

# The origin will be save

book.write_and_preserve_attribute(:author, 'Sun Zi')
#=> #<Book _id: 4f68d82f9421794f48000001, title: "Art of war", author: "Sun Zi", _type: nil, country: "China">

book.genesis
#=> #<BookGenesis _id: 4f68d82f9421794f48000002, _type: nil, author: "Sun Tzu">

# The origin will not be overwritten

book.write_and_preserve_attribute(:author, 'Sun Wu')
#=> #<Book _id: 4f68d82f9421794f48000001, title: "Art of war", author: "Sun Wu", _type: nil, country: "China">

book.genesis
#=> #<BookGenesis _id: 4f68d82f9421794f48000002, _type: nil, author: "Sun Tzu">

# Restoring the origin

book.restore_genesis(:author)
#=> #<Book _id: 4f68d82f9421794f48000001, title: "Art of war", author: "Sun Tzu", _type: nil, country: "China">

book.genesis
#=> #<BookGenesis _id: 4f68d82f9421794f48000002, _type: nil, author: nil>

# To make some modifications on the original without losing the current state

book.write_and_preserve_attribute(:title, 'The Art of Peace')
book.reverse_genesis

#=> #<Book _id: 4f68d82f9421794f48000001, title: "The Art of War", author: "Sun Tzu", _type: nil, country: "China">
#=> #<BookGenesis _id: 4f68d82f9421794f48000002, _type: nil, title: "The Art of Peace">

book.title = "The Art of War : Revisited"
book.reverse_genesis

#=> #<Book _id: 4f68d82f9421794f48000001, title: "The Art of Peace", author: "Sun Tzu", _type: nil, country: "China">
#=> #<BookGenesis _id: 4f68d82f9421794f48000002, _type: nil, title: "The Art of War : Revisited">

```

Copyright
---------

Copyright (c) 2012 De Marque inc. See LICENSE for further details.
