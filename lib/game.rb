require './lib/game_setup'
require './lib/guess_responses'

class Game
  include GameSetup
  include GuessResponses

  attr_reader   :guess_counter,  :number,
                :parser,         :responses

  def initialize(parser, number, counter, responses)
    @parser         = parser
    @verb           = parser.verb
    @number         = number
    @unparsed_guess = parser.guess
    @responses      = responses
    @guess_counter  = counter
  end

  def go
    if low_guess
      low_guess_response
    elsif high_guess
      high_guess_response
    elsif correct_guess
      correct_guess_response
    end
  end
  
end