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

  def guess_finder
    isolator = full_request[3].chars
    2.times { isolator.pop }
    isolator.join("")[-1].to_i
  end
  
  def hello
    "Hello, world! #{server.counter}"
  end

  def root
    ""
  end

  def datetime
    Time.now.strftime('%I:%M %p on %A, %b %d, %Y')
  end

  def shutdown
    "Count: #{server.counter}"
  end

  def word_search
    WordSearch.new(path).go
  end

  def forbidden
    error_gif + "\n403 FORBIDDEN!!!"
  end

  def system_error
    error_gif + "500 : " + generate_error
  end

  def unknown
    error_gif + "\n404 Unknown!!!"
  end

  def game
    server.game_counter += 1
    server.game_started = true
    Game.new(self, server.number, server.game_counter, server.game_responses).sort_by_verb
  end

  def error_gif
    "<iframe src=\"//giphy.com/embed/TUc0ZkK15eiTC\" width=\"480\" height=\"270\" frameBorder=\"0\" class=\"giphy-embed\" allowFullScreen></iframe><p><a href=\"http://giphy.com/gifs/wtf-tim-and-eric-wut-TUc0ZkK15eiTC\"></a></p>"
  end

  def generate_error
    raise SystemError
    rescue => detail
    detail.backtrace.join("\n")
  end

end