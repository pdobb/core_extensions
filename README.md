# Core Extensions

This is a collection of core extensions to Ruby and Rails components.


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
  config.extensions = ["Exception", "Range", "Hash"]
end
```

Currently the only configuration option is `extensions`, which is an Array of Core Object names to be extended during gem initialization (by default this is set to `["Exception", "Range", "Hash"]`). The Available Core Extensions section below lists the available Core Extensions.


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

### Hash

Includes:

* Hash#swap

A temporary swap of new key/values into the hash, for the duration of the block.


```ruby
hash = { a: 1, b: 2 }
hash.swap(a: "a", b: "b", c: "c") do
  hash[:a]  # => "a"
  hash[:b]  # => "b"
  hash[:c]  # => "c"
end
hash[:a]  # => 1
hash[:b]  # => 2
hash[:c]  # => nil
```


### PrefixesHelper

Adds helper methods for adding ActionView::LookupContext prefixes on including controllers.

Includes:

* #prepend_lookup_context_prefixes(prefix)

Prepends the passed in prefix to the current `lookup_context.prefixes` list if not already present in the first position.

*Note*: Modification of the lookup_context prefixes is cached, so it is important to use `around_action` calls when using these methods. When passing the `&block` in to the provided methods, they will then take care of removing the prefixes after the action is yielded.

```ruby
class MyObjectsController < ApplicationController
  include PrefixesHelper

  around_action only: :show do |_, block|
    prepend_lookup_context_prefixes("my_optional_name_space/my_objects", &block)
  end

  def show
    # Will now look for the "show" template and relatively-pathed partials at
    # "my_optional_namespace/my_other_objects/" first, then
    # "my_objects_controller/" second, and so on for the usual template
    # inheritance lookup path.
  end
end
```

* #append_penultimate_lookup_context_prefixes(prefix)

Sets the penultimate (2nd-to-last) prefix in the current `lookup_context.prefixes` list if not already present in the penultimate position.

```ruby
class MyObjectsController < ActionController::Base
  include PrefixesHelper

  around_action only: %i[index edit update] do |_, block|
    append_penultimate_lookup_context_prefixes("my_optional_name_space/my_objects", &block)
    # Will now look for templates and relatively-pathed partials in
    # "my_objects_controller/" first, and so on for the usual template, except
    # that "my_optional_namespace/my_other_objects/" will be searched
    # second-to-last -- just before "application/".
  end
end
```

## Author

- Paul Dobbins
