require 'json'
require_relative 'lib/number_entry'
require_relative 'lib/word_entry'
require_relative 'lib/pretty_printer'

tokens = {
  perfect_number: ['P#'],
  factorial_of: ['\:\s{0,}\d{1,}\.', '\.\-\-'],
  sub_factorial_of: ['\:\:\s*\d+\.', ':\.-\-'],
  pi: ['Pi'],
  square_root: ['Sq\.Rt\.'],
  sum: ['SUM\s\(\d{1,}\-\d{1,}\)\.'],
  power: ['\d{1,}\sto\sthe\s\d{1,}..\spower\s{0,}\.{0,1}']
}

book_entries = File.read('input.txt').split("\n\n")
sepher_sephiroth = []

# range = (1..3321)
range = (1..5)

range.to_a.each do |number|
  # Look for the block
  block = book_entries[number - 1]

  number_entry = NumberEntry.new(number)

  # Extract number
  block = block.sub(Regexp.new("\s#{number}"), (' ' * (number.to_s.size + 1)))

  # Extract tags
  tokens.each do |token, expressions|
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
  sepher_sephiroth << number_entry
end

json = JSON.pretty_generate(sepher_sephiroth)
File.write('output.json', json)

pretty_printer = PrettyPrinter.new(sepher_sephiroth)
pretty_printer.print
