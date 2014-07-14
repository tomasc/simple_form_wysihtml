module SimpleFormWysihtml
  class WysihtmlInput < SimpleForm::Inputs::Base

    class << self

      attr_accessor :configuration

      def configure
        @configuration ||= Configuration.new
        yield @configuration
      end

      def configuration
        @configuration ||= Configuration.new
      end

    end

    # =====================================================================

    # @return [String]
    def input
      template.content_tag :div, class: %w(wysihtml_editor) do
        toolbar + text_area
      end
    end

    private # =============================================================

    # Array of commands for text area toolbar, arranged into command groups.
    # @return [Array]
    def command_list
      options[:commands] || SimpleFormWysihtml::WysihtmlInput.configuration.commands
    end

    # ---------------------------------------------------------------------

    # @return [String]
    def text_area
      @builder.text_area(attribute_name, input_html_options).html_safe
    end

    # @return [String]
    def toolbar
      template.content_tag :div, class: 'toolbar' do
        commands + dialogs
      end.html_safe
    end

    # @return [String]
    def commands
      template.content_tag :ul, class: 'commands' do
        command_list.collect do |group|
          command_group(group)
        end.join.html_safe
      end
    end

    # @param [Array] group
    # @return [String]
    def command_group group
      template.content_tag :li, class: 'command_group' do
        group.map do |command, options|
          self.send(command, options || {})
        end.join.html_safe
      end.html_safe
    end

    # @param [String]
    def dialogs
      flattened_command_list = command_list.inject({}){ |res, i| res.merge!(i) }
      command_list_with_dialog = flattened_command_list.select{ |k,v| %w(createLink insertImage).include?(k.to_s) }

      return unless command_list_with_dialog.present?

      template.content_tag :div, class: 'dialogs' do
        command_list_with_dialog.map do |command, options|
          self.send("#{command}_dialog", options || {})
        end.join.html_safe
      end
    end

    # ---------------------------------------------------------------------

    # @param [Hash] options
    # @return [String]
    def bold options={}
      label = options[:label] || 'Bold'

      command_tag 'bold', label
    end

    # @param [Hash] options
    # @return [String]
    def createLink options={}
      label = options[:label] || 'Link'
      value = options[:value] || 'http://'

      command_tag('createLink', label, value)
    end

    # @param [Hash] options
    # @return [String]
    def createLink_dialog options={}
      dialog_label = options[:dialog_label] || 'Link:'
      value = options[:value] || 'http://'
      dialog_field = dialog_field_tag('href', value)

      dialog_tag('createLink', dialog_label, dialog_field)
    end

    # @param [Hash] options
    # @retun [String]
    def fontSize options={}
      label = options[:label] || 'Size'
      value = options[:value] || 'small'

      command_tag 'fontSize', label, value
    end

    # @param [Hash] options
    # @return [String]
    def foreColor options={}
      label = options[:label] || 'Color'
      value = options[:label] || 'red'

      command_tag 'foreColor', label, value
    end

    # @param [Hash] options
    # @return [String]
    def formatBlock options={}
      label = options[:label] || 'Block'
      value = options[:value] || 'h1'

      command_tag 'formatBlock', label, value
    end

    # @param [Hash] options
    # @return [String]
    def formatInline options={}
      label = options[:label] || 'Inline'
      value = options[:value] || 'span'

      command_tag 'formatInline', label, value
    end

    # @param [Hash] options
    # @return [String]
    def insertHTML options={}
      label = options[:label] || 'HTML'
      value = options[:value] || '<blockquote>foobar</blockquote>'

      command_tag 'insertHTML', label, value
    end

    # @param [Hash] options
    # @return [String]
    def insertImage options={}
      label = options[:label] || 'Image'
      value = options[:value] || 'http://'

      command_tag('insertImage', label)
    end

    # @param [Hash] options
    # @return [String]
    def insertImage_dialog options={}
      dialog_label = options[:dialog_label] || 'Image:'
      value = options[:value] || 'http://'
      dialog_field = dialog_field_tag('src', value)

      dialog_tag('createLink', dialog_label, dialog_field)
    end

    # @param [Hash] options
    # @return [String]
    def insertLineBreak options={}
      label = options[:label] || 'Line Break'

      command_tag 'insertLineBreak', label
    end

    # @param [Hash] options
    # @return [String]
    def insertOrderedList options={}
      label = options[:label] || 'OL'

      command_tag 'insertOrderedList', label
    end

    # @param [Hash] options
    # @return [String]
    def insertUnorderedList options={}
      label = options[:label] || 'UL'

      command_tag 'insertUnorderedList', label
    end

    # @param [Hash] options
    # @return [String]
    def italic options={}
      label = options[:label] || 'Italic'

      command_tag 'italic', label
    end

    # @param [Hash] options
    # @return [String]
    def justifyCenter options={}
      label = options[:label] || 'Center'

      command_tag 'justifyCenter', label
    end

    # @param [Hash] options
    # @return [String]
    def justifyLeft options={}
      label = options[:label] || 'Left'

      command_tag 'justifyLeft', label
    end

    # @param [Hash] options
    # @return [String]
    def justifyRight options
      label = options[:label] || 'Right'

      command_tag 'justifyRight', label
    end

    # @param [Hash] options
    # @return [String]
    def redo options={}
      label = options[:label] || 'Redo'

      command_tag 'redo', label
    end

    # @param [Hash] options
    # @return [String]
    def underline options={}
      label = options[:label] || 'Underline'

      command_tag 'underline', label
    end

    # @param [Hash] options
    # @return [String]
    def undo options={}
      label = options[:label] || 'Undo'

      command_tag 'undo', label
    end

    # ---------------------------------------------------------------------

    # Generates link for specified command
    #
    # @param [String] command
    # @param [String] label
    # @param [String] value
    # @return [String]
    def command_tag command, label, value=nil
      options = { 'data-wysihtml5-command' => command }
      options.merge!({ 'data-wysihtml5-command-value' => value }) if value.present?
      options.merge!({ class: 'command button' })

      template.content_tag :a, options do
        label
      end.html_safe
    end

    # @param [String] command
    # @param [String] label
    # @param [String] dialog_field
    # @return [String]
    def dialog_tag command, label, dialog_field
      options = { 'data-wysihtml5-dialog' => command, style: 'display: none' }
      options.merge!({ class: 'dialog' })

      template.content_tag :div, options do
        template.content_tag(:label, (label + dialog_field).html_safe).html_safe +
          action_tag('save', 'OK') +
          action_tag('cancel', 'Cancel')
      end.html_safe
    end

    # @param [String] action
    # @param [String] label
    # @return [String]
    def action_tag action, label
      template.content_tag :a, 'data-wysihtml5-dialog-action' => action, class: 'button' do
        label
      end.html_safe
    end

    # @param [String] att
    # @param [String] value
    # @return [String]
    def dialog_field_tag att, value=nil
      "<input data-wysihtml5-dialog-field='#{att}' value='#{value}'>".html_safe
    end

    # ---------------------------------------------------------------------

  end
end