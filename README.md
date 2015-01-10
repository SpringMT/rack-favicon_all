# Rack::FaviconAll

Generate favicons for IE, FF, Chrome, Safari!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-favicon_all'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-favicon_all

## Usage

In Gemfile

```
gem 'rack-favicon_all'
```

And write in config.ru below

```
require 'rack/favicon_all'
use Rack::FaviconAll, favicon_path: "path/to/favicon.png"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rack-favicon_all/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
