# Simple Form Wysihtml

Integrates [Wysihtml5](http://xing.github.io/wysihtml5) editor (resp. [this branch](https://github.com/Edicy/wysihtml5) of it) with Rails and [Simple Form](https://github.com/plataformatec/simple_form).

## Installation

Add the gem to your Gemfile:

    gem 'simple_form_wysihtml'

And execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_form_wysihtml

To make it work you need to require the javascripts in `application.js`:

    //= require simple_form_wysihtml

Optionally you can add the (very minimal) default styling in `application.css`:

    *= require 'simple_form_wysihtml'

## Usage

Use in forms:

    = form.input :body, as: :wysihtml

## Styling

See [simple_form_wysihtml.css.scss](https://github.com/tomasc/simple_form_wysihtml/blob/master/lib/assets/stylesheets/simple_form_wysihtml.css.scss) for how to style the editor.

## Configuration

### The toolbar

You can override the defaults by specifying the toolbar in an initializer:

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

Alternatively, you can configure individual input fields in the form:

```Slim
= f.input :body, as: :wysihtml, commands: [{ bold: { label: 'B' } }, { italic: { label: 'I' } }]
```

See the [list of available commands](https://github.com/Edicy/wysihtml5/tree/master/src/commands).

### Parser rules

The parser rules are defined as a javascript variable, containing a hash of rules (see [Wysihtml5x](https://github.com/Edicy/wysihtml5/tree/master/parser_rules).

Add a javascript file with your own parser rules (namespaced for example like this):

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

Then in your initializer assign the `parser_rules` to the name of your JS variable:

```Ruby
# config/initializers/simple_form_wysihtml.rb

SimpleFormWysihtml::WysihtmlInput.configure do |c|
  c.parser_rules = 'YourCoolNameSpace.parserRules'
end
```

## TODO

Add the following commands from wysihtml5:

* addTableCells
* bgColorStyle
* removeLink
* createTable
* deleteTableCells
* fontSizeStyle
* foreColorStyle
* justifyFull
* mergeTableCells

Reference: [wysihtml5 wiki](https://github.com/edicy/wysihtml5/wiki/Supported-Commands).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/simple_form_wysihtml/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
