require_relative 'hebrew'
require_relative 'base_entry'

class WordEntry < BaseEntry
  attr_reader :word

  def initialize(word)
    @word = word
  end

  def hebrew
    Hebrew.to_hebrew(word)
  end

  def gematria
    Hebrew.to_gematria(word)
  end

  def as_json(options={})
    {
      word: word,
      hebrew: hebrew,
      desc: desc
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end
