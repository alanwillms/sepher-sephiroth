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
