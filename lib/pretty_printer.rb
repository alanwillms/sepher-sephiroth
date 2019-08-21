require 'colorize'

class PrettyPrinter
  def initialize(entries)
    @entries = entries
  end

  def print
    @entries.each do |entry|
      puts entry.number.to_s.colorize(:red)
      puts entry.desc.colorize(:blue) unless entry.desc.to_s.empty?
      puts "\n"
      entry.words.each do |word|
        output_line = "\t"
        gematria = word.gematria
        output_line += ("[" + gematria.to_s + "] ").colorize(:red) if gematria != entry.number
        output_line += word.hebrew.colorize(:green) + " (" + (word.word.to_s).colorize(:green) + "): "
        puts output_line + word.desc.to_s
      end
      puts "\n"
    end
  end
end
