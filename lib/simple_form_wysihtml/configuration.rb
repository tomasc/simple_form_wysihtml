module SimpleFormWysihtml
  class Configuration

    attr_accessor :parser_rules

    def initialize
      @parser_rules = {
        tags: {
          strong: {},
          b:      {},
          i:      {
            rename_tag: "b"
          },
          em:     {},
          br:     {},
          p:      {},
          div:    {},
          span:   {},
          ul:     {},
          ol:     {},
          li:     {},
          a:      {
            set_attributes: {
              target: "_self",
              rel:    "nofollow"
            },
            check_attributes: {
              href:   "url" # important to avoid XSS
            }
          }
        }
      }
    end

  end
end