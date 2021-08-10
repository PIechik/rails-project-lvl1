# HexletCode

This gem renders html forms

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexlet_code'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hexlet_code

## Usage

```ruby
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

form = HexletCode.form_for user do |f|
  f.input :name
  f.input :job, as: :text
  f.input :gender, as: :select, collection: %w[m f]
  f.submit
end

# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input type="text" name="name">
#   <label for="job">Job</label>
#   <textarea cols="20" rows="40" name="job">hexlet</textarea>
#   <label for="gender">Gender</label>
#   <select name="gender">
#     <option value="m" selected>m</option>
#     <option value="f">f</option>
#   </select>
#   <input type="submit" value="Save" name="commit">
# </form>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hexlet_code.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

### Hexlet tests and linter status:
[![Actions Status](https://github.com/PIechik/rails-project-lvl1/workflows/hexlet-check/badge.svg)](https://github.com/PIechik/rails-project-lvl1/actions)
