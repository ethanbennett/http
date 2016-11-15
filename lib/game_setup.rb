module GameSetup

  def guess
    # require 'pry'; binding.pry
    value  = parser.server.client.read(@unparsed_guess)
    @guess = value.split(/=/)[-1].to_i
  end

  def increase_count
    parser.server.game_counter += 1
  end

  def current_number_of_guesses
    "<h1>Current number of guesses: #{guess_counter}</h1>"
  end

  def sort_by_verb
    if verb.eql?('GET')
      get_response
    elsif verb.eql?('POST') && @unparsed_guess.eql?(0)
      "<pre>Good Luck!</pre>"
    elsif verb.eql?('POST')
      go
    end
  end

  def get_response
    current_number_of_guesses
  end

  def low_guess
    guess < number
  end

  def low_guess_response
    "<pre>
    <br/>Your guess is too low!
    <br/>Current number of guesses: #{guess_counter}
    </pre>"
  end

  def high_guess
    @guess > number
  end

  def high_guess_response
    "<pre>
    <br/>Your guess is too high!
    <br/>Current number of guesses: #{guess_counter}
    </pre>"
  end

  def correct_guess
    @guess == number
  end

  def correct_guess_response
    response = "<pre>
    <br/>You guessed correctly!
    <br/>It took you this many tries: #{guess_counter}
    </pre>"
    reset_variables
    response
  end

  def reset_variables
    parser.server.number = Random.rand(100)
    parser.server.game_counter = 1
  end

end