# Redis::Mapper

Use Redis as multi-column database for structured data

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redis-mapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis-mapper

## Usage

### Create class

```ruby
class User
  include Redis::Mapper

  @host = "127.0.0.1"
  @port = 6379
  @db = 1
end
```

### Establish connection

You must run redis-server on the host before bellow statement.

```ruby
User.establish_connection
```

### Create object

There are three kind of methods used for creating an object.

```ruby
matz = User.create!("matz")         # create new object
matz = User.find("matz")            # create the object from redis
matz = User.find_or_create("matz")  # create the object from redis if exists,
                                    # else create new object
```

### Set value

```ruby
matz.set("age", 50)
matz.set("name", "Yukihiro Matsumoto")
matz.set("birthday", {"year" => 1965, "month" => 4, "day" => 14})
matz.set("languages", ["Japanese", "English", "Ruby"])
```

### Get value

```ruby
matz.get("age")       #=> 50
matz.get("name")      #=> "Yukihiro Matsumoto"
matz.get("birthday")  #=> {"year" => 1965, "month" => 4, "day" => 14}
matz.get("languages") #=> ["Japanese", "English", "Ruby"]
```

### Save object

```ruby
matz.save # save to memory
User.dump # save to disk
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/redis-mapper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
