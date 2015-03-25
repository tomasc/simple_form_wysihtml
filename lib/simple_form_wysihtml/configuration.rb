module SimpleFormWysihtml
  class Configuration

    attr_accessor :commands, :options

    def initialize
      @options = {
        parserRules: 'SimpleFormWysihtml.parserRules',
        useLineBreaks: false
      }
      @commands = [
        { bold: { label: 'B' }, italic: { label: 'I' } },
        { createLink: nil },
        { insertOrderedList: nil, insertUnorderedList: nil },
        { undo: nil, redo: nil }
      ]
    end

  end
end