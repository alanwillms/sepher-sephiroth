require 'prime'

class NumberEntry
  attr_reader :number, :desc, :words, :tags

  def initialize(number)
    @number = number
    @desc = nil
    @words = []
    @tags = []
  end

  def add_tag(tag)
    @tags << tag
  end

  def add_word(word)
    @words << word
  end

  def append_desc(desc)
    @desc ||= ''
    @desc = (@desc + ' ' + desc + ' ').gsub(/\s{2,}/, ' ').strip
  end

  def perfect?
    # static because it's too costly to calculate
    @number == 1 || @number == 6 || @number == 28 || @number == 496
  end

  def prime?
    Prime.prime? @number
  end

  def perfect_square?
    square = Math.sqrt(@number)
    square % 1 == 0
  end

  def perfect_cube?
    return false if @number == 1 # Liber D doesn't show it
    root = @number ** (1.0 / 3)
    root % 1 == 0
  end

  def perfect_squared_square?
    return false if @number == 1 # Liber D doesn't show it
    root = @number ** (1.0 / 4)
    root % 1 == 0
  end

  def sum?
    # static because it's too costly to calculate 1-81
    # @number == 2 || @number == 6 || @number == 10 # and so on...
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
