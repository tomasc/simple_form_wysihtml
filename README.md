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

The parser rules are configured by calling your own javascript variable, containing a hash of rules.

Add an initializer to the app:

```Ruby
# config/initializers/simple_form_wysihtml.rb

SimpleFormWysihtml::WysihtmlInput.configure do |c|
  c.parser_rules = 'YourCoolNameSpace.parserRules'
end
```

And add a javascript file with your own parser rules:

```js
// app/assets/javascripts/parser_rules.js

YourCoolNameSpace = (function(){

  var YourCoolNameSpace = {
    parserRules: {
      tags: {
        i: {
          rename_tag: 'em'
        },

        a: {
          set_attributes: {
            target: "_self"
          }
        }
      }
    }
  }

  return YourCoolNameSpace;
})();
```

See [Wysihtml5x](https://github.com/edicy/wysihtml5) for parser options.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/simple_form_wysihtml/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
