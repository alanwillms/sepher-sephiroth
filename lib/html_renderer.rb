require 'erb'

class HtmlRenderer
  def initialize(sepher_sephiroth)
    @sepher_sephiroth = sepher_sephiroth
  end

  def output(filename)
    output = '<table class="table is-striped is-condensed is-bordered">'
    @sepher_sephiroth.each do |entry|
      output += "<tr>\n"
      if entry.desc.to_s.empty?
        output += '<th colspan="2" class="has-text-right">' + entry.number.to_s + "</th>\n"
      else
        output += "<td>" + entry.desc + "</td>\n"
        output += '<th class="has-text-right">' + entry.number.to_s + "</th>\n"
      end

      output += "</tr>\n"

      entry.words.each do |word|
        gematria = word.gematria
        if gematria == entry.number
          output += "<tr>\n"
        else
          output += '<tr class="has-background-danger has-text-white">' + "\n"
        end
        output += '<td>' + word.desc.to_s + "</td>\n"
        output += '<td class="has-text-right">'
        output += ("<strong>[" + gematria.to_s + "]</strong> ") if gematria != entry.number
        output += word.hebrew + " (" + (word.word.to_s) + ")</td>\n"
        output += "</tr>\n"
      end
    end
    output += '</table>'
    template = ERB.new(File.read('templates/layout.erb.html'))
    File.write(filename, template.result(binding))
  end
end
