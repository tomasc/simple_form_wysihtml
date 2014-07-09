# https://github.com/zenorocha/jquery-boilerplate
(($, window) ->



  # ---------------------------------------------------------------------



  pluginName = 'wysihtml'
  document = window.document

  defaults =
    debug: false



  # ---------------------------------------------------------------------



  class Plugin



    constructor: (@element, options) ->
      @options = $.extend {}, defaults, options

      @$element = $(@element)

      @wysihtml_id = 'wysihtml_' + new Date().getTime()
      @textarea_id = @wysihtml_id + '_textarea'
      @toolbar_id = @wysihtml_id + '_toolbar'

      @$textarea = @$element.find('textarea')
      @$toolbar = @$element.find('.toolbar')

      @_defaults = defaults
      @_name = pluginName

      @init()



    init: ->
      # assign unique id, because wysihtml5 needs it
      @$textarea.attr 'id', @textarea_id
      @$toolbar.attr 'id', @toolbar_id

      # init editor
      @editor = new wysihtml5.Editor(@textarea_id,
        allowObjectResizing: true
        autoLink: true # TODO: perhaps settable via data or class on the textarea
        parserRules: wysihtml5ModulorParserRules # TODO: parser rules should depend on buttons defined
        supportTouchDevices: true
        style: true
        toolbar: @toolbar_id
      )



  # ---------------------------------------------------------------------



  # prevents multiple instantiation on same DOM element
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))



  # ---------------------------------------------------------------------



)(jQuery, window)



# =====================================================================



$ ->



  $('div.modulor.wysihtml').wysihtml()

  $('body').on 'dom_update', (e) ->
    $('div.modulor.wysihtml').wysihtml()


