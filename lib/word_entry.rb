require_relative 'hebrew'

class WordEntry
  attr_reader :word, :desc

  def initialize(word)
    @word = word
    @desc = nil
  end

  def append_desc(desc)
    @desc ||= ''
    @desc = (@desc + ' ' + desc + ' ').gsub(/\s{2,}/, ' ').strip
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
