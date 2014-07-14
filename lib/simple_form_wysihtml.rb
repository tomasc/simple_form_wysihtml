require "simple_form"
require "simple_form_wysihtml/engine"
require "simple_form_wysihtml/configuration"
require "simple_form_wysihtml/simple_form_wysihtml"
require "simple_form_wysihtml/version"

require "rails-assets-wysihtml5x"

# ---------------------------------------------------------------------

module SimpleForm
  class FormBuilder
    map_type :wysihtml, to: SimpleFormWysihtml::WysihtmlInput
  end
end