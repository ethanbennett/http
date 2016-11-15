require './lib/game_setup'

class Game
  include GameSetup

  attr_reader   :guess_counter,  :number,
                :parser,         :verb,
                :responses

  def initialize(parser, unparsed_guess)
    parser.server.game_started = true
    @parser         = parser
    @verb           = parser.verb
    @number         = parser.server.number
    @guess_counter  = parser.server.game_counter
    @unparsed_guess = unparsed_guess
    @responses      = parser.server.game_responses
  end

  def go
    increase_count 
    if low_guess
      low_guess_response
    elsif high_guess
      high_guess_response
    elsif correct_guess
      correct_guess_response
    end
  end
  
end