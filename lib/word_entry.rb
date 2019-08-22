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
end
