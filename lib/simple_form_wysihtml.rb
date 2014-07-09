require "simple_form"
require "simple_form_wysihtml/engine"
require "simple_form_wysihtml/simple_form_wysihtml"
require "simple_form_wysihtml/version"

# ---------------------------------------------------------------------

module SimpleForm
  class FormBuilder
    map_type :wysihtml, to: SimpleFormWysihtml::WysihtmlInput
  end
end