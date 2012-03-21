Mongoid Genesis
===============

[![Build Status](https://secure.travis-ci.org/demarque/mongoid-genesis.png?branch=master)](http://travis-ci.org/demarque/mongoid-genesis)

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
book = Book.new(:title => 'Art of war', :author => 'Sun Tzu')
#=> #<Book _id: 1, title: "Art of war", author: "Sun Tzu">

book.genesis
#=> #<BookGenesis _id: 1>


# The origin will be save

book.write_and_preserve_attribute(:author, 'Sun Zi')
#=> #<Book _id: 1, title: "Art of war", author: "Sun Zi">

book.genesis
#=> #<BookGenesis _id: 1, author: "Sun Tzu">


# The origin will not be overwritten

book.write_and_preserve_attribute(:author, 'Sun Wu')
#=> #<Book _id: 1, title: "Art of war", author: "Sun Wu">

book.genesis
#=> #<BookGenesis _id: 1, author: "Sun Tzu">


# Restoring the origin

book.restore_genesis(:author)
#=> #<Book _id: 1, title: "Art of war", author: "Sun Tzu">

book.genesis
#=> #<BookGenesis _id: 1, author: nil>


# To make some modifications on the original without losing the current state

book.write_and_preserve_attribute(:title, 'The Art of Peace')
book.reverse_genesis

#=> #<Book _id: 1, title: "The Art of War", author: "Sun Tzu">
#=> #<BookGenesis _id: 1, title: "The Art of Peace">

book.title = "The Art of War : Revisited"
book.reverse_genesis

#=> #<Book _id: 1, title: "The Art of Peace", author: "Sun Tzu">
#=> #<BookGenesis _id: 1, title: "The Art of War : Revisited">

```

Copyright
---------

Copyright (c) 2012 De Marque inc. See LICENSE for further details.
