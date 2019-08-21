class BaseEntry
  attr_reader :desc

  def append_desc(desc)
    @desc ||= ''
    @desc = replace_with_symbols (@desc + ' ' + desc + ' ').gsub(/\s{2,}/, ' ').strip
  end

  private

  def replace_with_symbols(desc)
    desc
      .gsub('Moon', '☽')
      .gsub('Mercury', '☿')
      .gsub('Venus', '♀')
      .gsub('Sun', '☉')
      .gsub('Mars', '♂')
      .gsub('Jupiter', '♃')
      .gsub('Saturn', '♄')
      .gsub('Aries', '♈')
      .gsub('Taurus', '♉')
      .gsub('Gemini', '♊')
      .gsub('Cancer', '♋')
      .gsub('Leo', '♌')
      .gsub('Virgo', '♍')
      .gsub('Libra', '♎')
      .gsub('Scorpio', '♏')
      .gsub('Sagittarius', '♐')
      .gsub('Capricorn', '♑')
      .gsub('Aquarius', '♒')
      .gsub('Pisces', '♓')
      .gsub('♑us', 'Capricornus')
  end
end
