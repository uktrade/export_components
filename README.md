# ExportComponents

ExportComponents is a library for the shared great.gov.uk header and footer.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'export_components', :git => 'git://github.com/uktrade/export_components.git'
```

And then execute:

    $ bundle

## Usage

Include the js:

```
//= require export-components-header
```

Include the css:
```
// require export-components
```

or

```
@import 'export-components';
```

Include the ERB templates:

```
<%= render partial: 'export_components/header' %>
<%= render partial: 'export_components/footer' %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/uktrade/export_components

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
