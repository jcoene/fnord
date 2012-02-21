# Fnord

A FnordMetric client for Ruby. Events are sent via UDP, something that isn't currently in FnordMetric master (but should be).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "fnord"
```

Update your bundle and you're ready to go.

## Usage

You'll need to create an instance of the Fnord class somewhere. A typical place to do this in Rails would be in an initializer, such as `/config/initializers/fnord.rb`:

```ruby
require "fnord"
$fnord = Fnord.new host: ENV["FNORD_HOST"], port: ENV["FNORD_PORT"], namespace: ENV["FNORD_NAMESPACE"]
```

### Configuration

There are three configuration options: `host` (required), `port` (required) and `namespace` (optional). They can be specified in a hash to the initializer (as seen in the example above) or specified after initialization via accessors.

### Send an Event

The `event` method takes two arguments:

- The name of the event (a String)
- An optional hash of additional arguments

### Send a Timed event

The `time` method is identical to `event` but takes a block. The duration (in real time) it takes to execute the block will be stored in a `time` value appended to your options hash before sending the event.

## Examples

You're running a pet adoption site (good for you).

Let's track page views:

```ruby
# Sends {"_type":"page_view"}
$fnord.event "page_view"
```

That might be more helpful with a url attached:

```ruby
# Sends {"_type":"page_view","url":"/dog/123"}
$fnord.event "page_view", url: request.env['PATH_INFO']
```

Someone is interested in a dog (yay!)

```ruby
# Sends {"_type":"dog_inquiry","id":123,"breed":"french_bulldog","name":"Alfie"}
$fnord.event "dog_inquiry", id: @dog.id, breed: "french_bulldog", name: "Alfie"
```

How long does it take (in ms) to process a background job to update all of your dogs?

```ruby
# sends {"_type":"update_dogs","time":3131}
$fnord.time "update_dogs" do
  # Censored in the interest of national security
end
```

## License

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
