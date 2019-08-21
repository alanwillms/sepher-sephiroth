class Hebrew
  KEY = [
    { name: 'Aleph', abbr: 'A', hebrew: 'א', latin: ['A', 'E'], value: 1 },
    { name: 'Beth', abbr: 'B', hebrew: 'ב', latin: ['B', 'F'], value: 2 },
    { name: 'Gimel', abbr: 'G', hebrew: 'ג', latin: ['G'], value: 3 },
    { name: 'Daleth', abbr: 'D', hebrew: 'ד', latin: ['D'], value: 4 },
    { name: 'He', abbr: 'H', hebrew: 'ה', latin: ['H'], value: 5 },
    { name: 'Vau', abbr: 'V', hebrew: 'ו', latin: ['V', 'U', 'W'], value: 6 },
    { name: 'Zain', abbr: 'Z', hebrew: 'ז', latin: ['Z'], value: 7 },
    { name: 'Cheth', abbr: 'Ch', hebrew: 'ח', latin: ['Ch'], value: 8 },
    { name: 'Yod', abbr: 'Y', hebrew: 'י', latin: ['Y', 'I', 'J'], value: 10 },
    { name: 'Kaph final', abbr: 'k', hebrew: 'ך', latin: ['k'], value: 500 },
    { name: 'Kaph', abbr: 'K', hebrew: 'כ', latin: ['K', 'C'], value: 20 },
    { name: 'Lamed', abbr: 'L', hebrew: 'ל', latin: ['L'], value: 30 },
    { name: 'Mem final', abbr: 'm', hebrew: 'ם', latin: ['m'], value: 600 },
    { name: 'Mem', abbr: 'M', hebrew: 'מ', latin: ['M'], value: 40 },
    { name: 'Nun final', abbr: 'n', hebrew: 'ן', latin: ['n'], value: 700 },
    { name: 'Nun', abbr: 'N', hebrew: 'נ', latin: ['N'], value: 50 },
    { name: 'Ayin', abbr: 'O', hebrew: 'ע', latin: ['O', "a'a"], value: 70 },
    { name: 'Peh final', abbr: 'p', hebrew: 'ף', latin: ['p'], value: 800 },
    { name: 'Peh', abbr: 'P', hebrew: 'פ', latin: ['P'], value: 80 },
    { name: 'Tzaddi final', abbr: 'tz', hebrew: 'ץ', latin: ['tz'], value: 900 },
    { name: 'Tzaddi', abbr: 'Tz', hebrew: 'צ', latin: ['Tz'], value: 90 },
    { name: 'Qoph', abbr: 'Q', hebrew: 'ק', latin: ['Q'], value: 100 },
    { name: 'Resh', abbr: 'R', hebrew: 'ר', latin: ['R'], value: 200 },
    { name: 'Shin', abbr: 'Sh', hebrew: 'ש', latin: ['Sh'], value: 300 },
    { name: 'Tau', abbr: 'Th', hebrew: 'ת', latin: ['Th'], value: 400 },
    { name: 'Teth', abbr: 'T', hebrew: 'ט', latin: ['T'], value: 9 },
    { name: 'Samekh', abbr: 'S', hebrew: 'ס', latin: ['S'], value: 60 },
  ]

  def self.to_hebrew(sentence)
    sentence = sentence.reverse
    KEY.each do |key|
      key[:latin].each do |latin_letter|
        sentence = sentence.gsub(latin_letter.reverse, key[:hebrew])
      end
    end
    sentence
  end

  def self.to_gematria(sentence)
    value = 0
    to_hebrew(sentence).split('').each do |hebrew_letter|
      KEY.each do |key|
        value += key[:value] if hebrew_letter == key[:hebrew]
      end
    end
    value
  end
end
