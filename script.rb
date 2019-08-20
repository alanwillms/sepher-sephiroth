require 'json'

class GematricNumber
  attr_accessor :number
  attr_accessor :desc

  def initialize
    @tags = []
    @words = []
    @desc = ''
  end

  def add_tag(name)
    @tags << name
  end

  def add_word(word)
    @words << word
  end

  def as_json(options={})
    {
      number: number,
      desc: desc,
      # tags: @tags.uniq,
      words: @words
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end

tokens = {
  perfect_number: ['P#'],
  factorial_of: [':\s*\d+.', '.--'],
  sub_factorial_of: ['::\s*\d+.', ':.--'],
  pi: ['Pi'],
  square_root: ['Sq.Rt.']
}

class String
  def is_i?
   /\A[-+]?\d+\z/ === self
  end
end

class HebrewWord
  attr_accessor :word, :desc

  def as_json(options={})
    {
      word: word,
      desc: desc
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end

entries = []

current_entry = GematricNumber.new
current_word = HebrewWord.new


File.readlines('input2.txt').each do |line|
  line = line.strip
  read_words = true

  # If there is a number at the end of line
  end_of_line = line.split(' ').last

  if end_of_line && end_of_line.is_i?
    read_words = false

    unless current_entry.number.nil?
      current_entry.add_word(current_word)
      entries << current_entry
      current_entry = GematricNumber.new
      current_word = HebrewWord.new
    end
    current_entry.number = end_of_line.to_i
  end

  # Check number for attributes
  tokens.each do |token, expressions|
    expressions.each do |expression|
      regex = Regexp.new('\s' + expression + '(\s|$)')
      if line.match? regex
        current_entry.add_tag(token)
        line = line.gsub(regex, '')
      end
    end
  end

  ending = line[37..]
  beginning = (' ' + line[0..36] + ' ')

  # There is a new word at the far right?
  if read_words
    if ending.nil?
      if current_word.word.nil?
        current_entry.desc = '' if current_entry.desc.nil?
        current_entry.desc += beginning
        current_entry.desc = current_entry.desc.gsub(/\s{2,}/, ' ').strip

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

    current_word.desc = '' if current_word.desc.nil?
    current_word.desc += beginning
    current_word.desc = current_word.desc.gsub(/\s{2,}/, ' ').strip
  else
    current_entry.desc = '' if current_entry.desc.nil?
    current_entry.desc += beginning
    current_entry.desc = current_entry.desc.gsub(/\s{2,}/, ' ').strip
  end
end

current_entry.add_word(current_word)
entries << current_entry

json = JSON.generate(entries)
# json = JSON.pretty_generate(entries)

File.write('output.json', json)
puts json
