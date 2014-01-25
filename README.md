# Core Extensions

This is a collection of core extensions.

## Compatibility

Tested with:

* Ruby: MRI 2.1.0 +

## Installation

Add this line to your application's Gemfile:

```ruby
gem "core_extensions", github: "pdobb/core_extensions"
```

And then execute:

```ruby
bundle
```

## Usage

The available core extensions have all been patched in, so are available on all
instances of the associated objects.

## Available Core Extensions

* Exception#inspect_backtrace(backtrace_cleaner = Rails::backtrace_cleaner)

Prints the exception class and message followed by an application-specific
backtrace. Or you may pass in a custom [backtrace_cleaner](http://api.rubyonrails.org/classes/ActiveSupport/BacktraceCleaner.html) or `nil`.

```ruby
begin
  asdf
rescue => ex
  logger.error ex.inspect_backtrace # Prints error info and application-specific backtrace
end
```

Or:

```ruby
begin
  asdf
rescue => ex
  logger.error ex.inspect_backtrace(nil) # Prints error info and full backtrace
end
```

## Author

- Paul Dobbins
