require 'json'

class JsonRenderer
  def initialize(sepher_sephiroth)
    @sepher_sephiroth = sepher_sephiroth
  end

  def output(filename)
    json = JSON.pretty_generate(@sepher_sephiroth)
    File.write(filename, json)
  end
end
