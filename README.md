Mongoid Genesis
===============

[![Build Status](https://secure.travis-ci.org/demarque/mongoid-genesis.png?branch=master)](http://travis-ci.org/demarque/mongoid-genesis)

Mongoid Genesis will give you the ability to override data in your model
without losing the initial data.

Install
-------

```
gem install mongoid-genesis
```

Rails 3
-------

In your Gemfile:

```ruby
gem 'mongoid-genesis'
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

**Basic structure**

```ruby
book = Book.new(:title => 'The Art of War', :author => 'Sun Tzu')
#=> #<Book _id: 1, title: "The Art of War", author: "Sun Tzu">

book.genesis
#=> #<BookGenesis _id: 1>
```

**Preserve the original attribute**

```ruby
book.write_and_preserve_attribute(:author, 'Sun Zi')
#=> #<Book _id: 1, title: "The Art of War", author: "Sun Zi">

book.genesis
#=> #<BookGenesis _id: 1, author: "Sun Tzu">
```

**After preserving the original attribute, it will not be overwritten**

```ruby
book.write_and_preserve_attribute(:author, 'Sun Wu')
#=> #<Book _id: 1, title: "The Art of War", author: "Sun Wu">

book.genesis
#=> #<BookGenesis _id: 1, author: "Sun Tzu">
```

**At all time, you can read the original attribute**

```ruby
book.read_attribute_genesis(:title)
#=> "The Art of War"

book.write_and_preserve_attribute(:title, 'The Art of Peace')
book.read_attribute_genesis(:title)
#=> "The Art of War"
```

**You can restore the original attribute**

```ruby
book.restore_genesis(:author)
#=> #<Book _id: 1, title: "The Art of War", author: "Sun Tzu">

book.genesis
#=> #<BookGenesis _id: 1, author: nil>
```

**To update the original document without losing the current state**

```ruby
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
