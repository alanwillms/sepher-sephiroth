require 'json'
require_relative 'lib/gematric_number'
require_relative 'lib/hebrew_word'
require_relative 'lib/pretty_printer'

tokens = {
  perfect_number: ['P#'],
  factorial_of: ['\:\s{0,}\d{1,}\.', '\.\-\-'],
  sub_factorial_of: ['\:\:\s*\d+\.', ':\.-\-'],
  pi: ['Pi'],
  square_root: ['Sq\.Rt\.'],
  sum: ['SUM\s\(\d{1,}\-\d{1,}\)\.'],
  power: ['\d{1,}\sto\sthe\s\d{1,}..\spower\s{0,}\.']
}

class String
  def is_i?
   /\A[-+]?\d+\z/ === self
  end
end

entries = []

current_entry = GematricNumber.new
current_word = HebrewWord.new

File.readlines('input2.txt').each do |line|
  line = line.strip
  line = line.gsub(/\s*\{\d*(a|b)\}/, '')
  read_words = true

  # If there is a number at the end of line
  if m = /\s(\d{1,})$/.match(line)
    read_words = false
    number = m[1].to_i

    # Validates number
    p {
      number: number,
      current: current_entry.number.to_i
    }.inspect
    if number == current_entry.number.to_i + 1
      unless current_entry.number.nil?
        current_entry.add_word(current_word) unless current_entry.number == 1
        entries << current_entry
        current_entry = GematricNumber.new
        current_word = HebrewWord.new
      end
      current_entry.number = number
      line = line.gsub(/\s(\d{1,})$/, '')
    end
  end

  # Check number for attributes
  tokens.each do |token, expressions|
    expressions.each do |expression|
      regex = Regexp.new('(\s|^)' + expression + '(\s|$)')
      if line.match? regex
        current_entry.add_tag(token)
        line = line.gsub(regex, '')
      end
    end
  end

  ending = line[37..]
  beginning = line[0..36]

  # There is a new word at the far right?
  if read_words
    if ending.nil?
      if current_word.word.nil?
        current_entry.append_desc beginning

        # Skips
        next
      end
    else
      unless current_word.word.nil?
        current_entry.add_word(current_word)
        current_word = HebrewWord.new
      end

      current_word.word = ending
    end

    current_word.append_desc beginning
  else
    current_entry.append_desc beginning
  end
end

current_entry.add_word(current_word)
entries << current_entry

json = JSON.generate(entries)
# json = JSON.pretty_generate(entries)

File.write('output.json', json)
# puts json

pretty_printer = PrettyPrinter.new(entries)
pretty_printer.print
