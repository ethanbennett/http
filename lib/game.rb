require './lib/game_setup'

class Game
  include GameSetup

  attr_reader   :request,  :guess_counter,
                :parser,   :verb,     
                :number

  def initialize(parser, request)
    @parser        = parser
    @request       = request
    @verb          = parser.verb
    @number        = parser.server.number
    @guess_counter = parser.server.game_counter
  end

  def go
    increase_count
    if correct_guess
      correct_guess_response 
    elsif low_guess
      low_guess_response
    elsif high_guess
      high_guess_response
    end
  end
  
end