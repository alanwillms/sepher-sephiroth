require_relative 'number_entry'
require_relative 'word_entry'
require_relative 'json_renderer'
require_relative 'txt_renderer'
require_relative 'html_renderer'

class SepherSephirothParser
  TOKENS = {
    perfect_number: ['P#'],
    factorial_of: ['\:\s{0,}\d{1,}\.', '\.\-\-'],
    sub_factorial_of: ['\:\:\s*\d+\.', ':\.-\-'],
    pi: ['Pi'],
    square_root: ['Sq\.Rt\.{0,1}'],
    third_root: ['3rd\sRt\.'],
    fourth_root: ['4th\sRt\.'],
    fifth_root: ['5th\s\.Rt\.'],
    sixth_root: ['6th\sRt\.'],
    seventh_root: ['7\sRt\.'],
    sum: ['SUM\s\(\d{1,}\s{0,}\-\s{0,}\d{1,}\)\.{0,}'],
    power: ['\d{1,}\sto\sthe\s\d{1,}..\spower\s{0,}\.{0,1}']
  }

  def initialize()
    @sepher_sephiroth = []
  end

  def parse(book_entries)
    range = (1..3321)

    range.to_a.each do |number|
      # Look for the block
      block = book_entries[number - 1]

      number_entry = NumberEntry.new(number)

      # Extract number
      block = block.to_s.sub(Regexp.new("\s\s#{number}"), (' ' * (number.to_s.size + 2)))

      # Extract book page number
      regex = Regexp.new('(\{)(\d{1,})(a|b)(\})')
      if m = block.match(regex)
        match_size = m[2].size
        block = block.sub(regex, ' ' + (' ' * match_size) + '  ')
      end

      # Extract tags
      TOKENS.each do |token, expressions|
        expressions.each do |expression|
          regex = Regexp.new('(\s|^)(' + expression + ')(\s|$)')
          if m = block.match(regex)
            match_size = m[2].size
            number_entry.add_tag(token)
            block = block.sub(regex, '\1' + (' ' * (match_size - 2)) + '\3')
          end
        end
      end

      # Read lines
      word_entry = nil

      block.split("\n").each do |line|
        beginning = line[0..36].to_s.strip
        ending = line[37..].to_s.strip

        if !ending.empty? && ending != "\u0001"
          number_entry.add_word(word_entry) if word_entry
          word_entry = WordEntry.new(ending)
          word_entry.append_desc(beginning)
        else
          if word_entry
            word_entry.append_desc(beginning)
          else
            number_entry.append_desc(beginning)
          end
        end
      end

      # Add last item
      number_entry.add_word(word_entry) if word_entry

      # Add to the book
      @sepher_sephiroth << number_entry
    end
  end

  def output
    JsonRenderer.new(@sepher_sephiroth).output('output/sepher_sephiroth.json')
    TxtRenderer.new(@sepher_sephiroth).output('output/sepher_sephiroth.txt')
    HtmlRenderer.new(@sepher_sephiroth).output('output/sepher_sephiroth.html')
  end
end
