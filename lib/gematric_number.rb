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

  def append_desc(desc)
    @desc = (@desc + ' ' + desc + ' ').gsub(/\s{2,}/, ' ').strip
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
