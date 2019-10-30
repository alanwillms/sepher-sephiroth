require_relative 'lib/sepher_sephiroth_parser'

book_entries = File.read('input.txt').split("\n\n")

@sepher_sephiroth = SepherSephirothParser.new
@sepher_sephiroth.parse(book_entries)
@sepher_sephiroth.output
