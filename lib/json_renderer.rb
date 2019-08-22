require 'json'

class JsonRenderer
  def initialize(sepher_sephiroth)
    @sepher_sephiroth = sepher_sephiroth
  end

  def output(filename)
    json = JSON.pretty_generate(@sepher_sephiroth.map do |number_entry|
      hash = {
        number: number_entry.number
      }

      hash[:desc] = number_entry.desc if number_entry.desc
      hash[:is_perfect] = true if number_entry.perfect?
      hash[:is_prime] = true if number_entry.prime?
      hash[:is_perfect_square] = true if number_entry.perfect_square?
      hash[:is_perfect_cube] = true if number_entry.perfect_cube?
      hash[:is_perfect_squared_square] = true if number_entry.perfect_squared_square?
      hash[:sum] = number_entry.sum if number_entry.sum?
      hash[:factorial] = number_entry.factorial if number_entry.factorial?
      hash[:subfactorial] = number_entry.subfactorial if number_entry.subfactorial?

      if number_entry.words.size > 0
        hash[:words] = number_entry.words.map do |word_entry|
          word_hash =  {
            word: word_entry.word,
            hebrew: word_entry.hebrew,
            gematria: word_entry.gematria
          }
          word_hash[:desc] = word_entry.desc if word_entry.desc
          word_hash
        end
      end

      hash
    end)
    File.write(filename, json)
  end
end
