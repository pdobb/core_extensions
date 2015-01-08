# Core Extensions

This is a collection of core extensions.


## Compatibility

Tested with:

* Ruby: MRI 1.9.3
* Ruby: MRI 2.0.0
* Ruby: MRI 2.1.2


## Installation

Add this line to your application's Gemfile:

```ruby
gem "core_extensions", github: "pdobb/core_extensions"
```

And then execute:

```ruby
bundle
```


## Configuration

Create an initializer to set custom configuration options, if needed.

```ruby
# config/initializers/conversions.rb

Conversions.configure do |config|
  config.extensions = ["Exception", "Range"]
end
```

Currently the only configuration option is `extensions`, which is an Array of Core Object names to be extended during gem initialization (by default this is set to `["Exception", "Range"]`). The Available Core Extensions section below lists the available Core Extensions.


## Usage

Core Extensions added via the `config` block will all been patched in, so are available on all instances of the associated objects.

## Available Core Extensions

### Exception

Includes:

* Exception#details

Prints the exception class and message.

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


### Range

Includes:

* Range#time_step

An iterator for stepping through a time range by a unit of time.


```ruby
(1.hour.ago..Time.current).time_step(15.minutes).map { |time| time.to_s(:short) }
=> ["08 Jan 08:10", "08 Jan 08:25", "08 Jan 08:40", "08 Jan 08:55", "08 Jan 09:10"]
```


## Author

- Paul Dobbins
