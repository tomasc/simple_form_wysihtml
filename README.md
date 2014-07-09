# Simple Form Wysihtml

Integrates [Wysihtml5](http://xing.github.io/wysihtml5) editor (resp. [this branch](https://github.com/Edicy/wysihtml5) of it) with Rails and [Simple Form](https://github.com/plataformatec/simple_form).

## Installation

Add this line to your application's Gemfile:

    gem 'simple_form_wysihtml'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_form_wysihtml

## Usage

Use in forms:

    = form.input :body, as: :wysihtml
    
## Configuration

TODO: describe global and local configuration options

## Contributing

1. Fork it ( https://github.com/[my-github-username]/simple_form_wysihtml/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
