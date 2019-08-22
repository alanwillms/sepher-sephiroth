require 'erb'

class HtmlRenderer
  def initialize(sepher_sephiroth)
    @sepher_sephiroth = sepher_sephiroth
  end

  def output(filename)
    output = '<table class="table is-striped is-condensed">'
    @sepher_sephiroth.each do |number_entry|
      text_slot = number_entry.desc.to_s
      number_slot = number_entry.number.to_s

      number_slot = '🌸 ' + number_slot if number_entry.perfect?
      number_slot = '√ ' + number_slot if number_entry.perfect_square?
      number_slot = '∛ ' + number_slot if number_entry.perfect_cube?
      number_slot = '∜ ' + number_slot if number_entry.perfect_squared_square?
      number_slot = 'π ' + number_slot if number_entry.prime?

      text_slot = '<u>||' + number_entry.subfactorial.to_s + '</u>. ' + text_slot if number_entry.subfactorial?
      text_slot = '<u>|' + number_entry.factorial.to_s + '</u>. ' + text_slot if number_entry.factorial?
      text_slot = 'Σ(' + number_entry.sum + ') ' + text_slot if number_entry.sum?

      output += "<tr>\n"
      output += '<td class="has-text-centered">' + text_slot + "</td>\n"
      output += '<th colspan="2" class="has-text-right">' + number_slot + "</th>\n"
      output += "</tr>\n"

      number_entry.words.each do |word|
        gematria = word.gematria
        if gematria == number_entry.number
          output += "<tr>\n"
        else
          output += '<tr class="has-background-danger has-text-white">' + "\n"
        end
        output += '<td>' + word.desc.to_s + "</td>\n"
        output += '<td class="has-text-right">'
        output += ("<strong>[" + gematria.to_s + "]</strong> ") if gematria != number_entry.number
        output += word.hebrew
        # output += " (" + (word.word.to_s) + ")"
        output += "</td><td>&nbsp;</td>\n"
        output += "</tr>\n"
      end
    end
    output += '</table>'
    template = ERB.new(File.read('templates/layout.erb.html'))
    File.write(filename, template.result(binding))
  end
end
