require 'prime'
require_relative 'base_entry'

class NumberEntry < BaseEntry
  attr_reader :number, :words, :tags

  @@sums = {}
  (2..81).to_a.each do |n|
    total = (1..n).sum
    @@sums[total] = "1-#{n}"
  end

  def initialize(number)
    @number = number
    @words = []
    @tags = []
  end

  def add_tag(tag)
    @tags << tag
  end

  def add_word(word)
    @words << word
  end

  def perfect?
    # static because it's too costly to calculate
    @number == 1 || @number == 6 || @number == 28 || @number == 496
  end

  def prime?
    return true if @number == 1 # Liber D says it is
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
    @@sums[@number]
  end

  def factorial?
    # static because it's too costly to calculate 1-81
    return 1 if @number == 1
    return 2 if @number == 2
    return 3 if @number == 6
    return 4 if @number == 24
    return 5 if @number == 120
    return 6 if @number == 720
  end

  def subfactorial?
    # static because it's too costly to calculate 1-81
    return 2 if @number == 1
    return 3 if @number == 2
    return 4 if @number == 9
    return 5 if @number == 44
    return 6 if @number == 265
    return 7 if @number == 1854
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
