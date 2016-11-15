require './lib/word_search'
require './lib/game'
require './lib/parser_setup'

class Parser
  include ParserSetup
  
  attr_reader   :host,    :verb,
                :path,    :protocol,
                :accept,  :counter,
                :server,  :full_request,
                :guess

  def initialize(server, request_lines)
    @server        = server
    @full_request  = request_lines
    @host          = host_finder
    @verb          = verb_finder
    @path          = path_finder
    @protocol      = protocol_finder
    @accept        = accept_finder
    @counter       = server.counter
    @guess         = guess_finder
  end

  def paths
    if path    == "/"
      root
    elsif path == "/hello"
      hello
    elsif path == "/datetime"
      datetime
    elsif path == "/shutdown"
      shutdown
    elsif path.include?("/wordsearch")
      word_search
    elsif path.include?("/game")
      game
    else
      error_gif
    end
  end

end