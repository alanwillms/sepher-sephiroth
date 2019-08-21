class TxtRenderer
  def initialize(sepher_sephiroth)
    @sepher_sephiroth = sepher_sephiroth
  end

  def output(filename)
    output = ''
    @sepher_sephiroth.each do |entry|
      output += entry.number.to_s + "\n"
      output += entry.desc unless entry.desc.to_s.empty?
      output += "\n"
      entry.words.each do |word|
        output_line = "\t"
        gematria = word.gematria
        output_line += ("[" + gematria.to_s + "] ") if gematria != entry.number
        output_line += word.hebrew + " (" + (word.word.to_s) + "): "
        output += output_line + word.desc.to_s + "\n"
      end
      output += "\n"
    end
    File.write(filename, output)
  end
end
