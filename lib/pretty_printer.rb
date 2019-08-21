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
        puts "\t" + (word.word.to_s).colorize(:green) + ": " + word.desc.to_s
      end
      puts "\n"
    end
  end
end
