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

### The toolbar

You can configure the available buttons in the toolbar in your own initializer file:

```Ruby
# config/initializers/simple_form_wysihtml.rb

SimpleFormWysihtml::WysihtmlInput.configure do |c|
  c.commands = [
    { bold: { label: 'Bold' }, italic: { label: 'Italic' } },
    { createLink:  { label: 'Create Link' } },
    { insertOrderedList: nil, insertUnorderedList: nil }
  ]
end
```
### Parser rules

The parser rules are defined as a javascript variable, containing a hash of rules.

Add a javascript file with your own parser rules like this (see [Wysihtml5x](https://github.com/edicy/wysihtml5) for available options):

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

Then add an initializer to the app, that fetches the `parserRules` variable:

```Ruby
# config/initializers/simple_form_wysihtml.rb

SimpleFormWysihtml::WysihtmlInput.configure do |c|
  c.parser_rules = 'YourCoolNameSpace.parserRules'
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/simple_form_wysihtml/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
