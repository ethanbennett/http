module ParserSetup

  def host_finder
    full_request[1].split(" ")[1]
  end

  def verb_finder
    full_request[0].split(" ")[0]
  end

  def path_finder
    full_request[0].split(" ")[1]
  end

  def protocol_finder
    full_request[0].split(" ")[2]
  end

  def accept_finder
    full_request[3..5]
  end
  
  def hello
    "Hello, world! #{counter}"
  end

  def root
    "Root"
  end

  def datetime
    Time.now.strftime('%I:%M %p on %A, %b %d, %Y')
  end

  def shutdown
    "Count: #{counter}"
  end

  def word_search
    WordSearch.new(path).go
  end

  def game
    Game.new(self, path).sort_by_verb
  end

  def error_gif
    "<iframe src=\"//giphy.com/embed/TUc0ZkK15eiTC\" width=\"480\" height=\"270\" frameBorder=\"0\" class=\"giphy-embed\" allowFullScreen></iframe><p><a href=\"http://giphy.com/gifs/wtf-tim-and-eric-wut-TUc0ZkK15eiTC\"></a></p>404!!!"
  end

end