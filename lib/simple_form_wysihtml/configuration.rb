module SimpleFormWysihtml
  class Configuration

    attr_accessor :commands, :parser_rules

    def initialize
      @parser_rules = 'SimpleFormWysihtml.parserRules'
      @commands = [
        { bold: { label: 'B' }, italic: { label: 'I' } },
        { createLink: nil },
        { insertOrderedList: nil, insertUnorderedList: nil },
        { undo: nil, redo: nil }
      ]
    end

  end
end