require './lib/parser'

class WordSearch
  attr_reader   :path

  def initialize(path)
    @path = path
  end

  def go
    if dictionary.include?(word)
      "#{word.upcase} is a known word."
    else
      "#{word.upcase} is not a known word."
    end
  end

  def dictionary
    reader     = File.read("/usr/share/dict/words")
    dictionary = reader.split(" ")
  end

  def word
    path.split("?")[1].split("=")[1]
  end
end