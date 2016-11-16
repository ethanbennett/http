module GameSetup

  def current_number_of_guesses
    "<h1>Current number of guesses: #{guess_counter}</h1>"
  end

  def sort_by_verb
    if @verb.eql?('GET')
      get_response
    elsif @verb.eql?('POST') && @unparsed_guess.eql?(0)
      "<pre>Good Luck!</pre>"
    elsif @verb.eql?('POST')
      go
    end
  end

  def get_response
    if responses[-1].nil?
      current_number_of_guesses
    else
      responses[-1]
    end
  end

  def guess
    value  = parser.server.client.read(@unparsed_guess)
    @guess = value.split(/=/)[-1].to_i
  end

  def reset_variables
    parser.server.number = Random.rand(100)
    parser.server.game_counter = 0
  end

end