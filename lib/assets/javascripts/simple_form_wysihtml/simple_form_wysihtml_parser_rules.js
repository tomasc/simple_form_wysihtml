// Sets up some sensible defaults

SimpleFormWysihtml = (function(){

  var SimpleFormWysihtml = {
    parserRules: {
      tags: {
        h1:     {},
        h2:     {},
        h3:     {},
        h4:     {},
        h5:     {},
        h6:     {},
        strong: {},
        b:      {
          rename_tag: 'strong'
        },
        i:      {
          rename_tag: 'em'
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
            href:   "url"
          }
        }
      }
    }
  }

  return SimpleFormWysihtml;
})();