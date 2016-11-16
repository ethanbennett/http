module GuessResponses

  def low_guess
    guess < number
  end

  def low_guess_response
    responses << "<pre>
    <br/>Your guess is too low!
    <br/>Current number of guesses: #{guess_counter}
    </pre>"
    responses[-1]
  end

  def high_guess
    @guess > number
  end

  def high_guess_response
    responses << "<pre>
    <br/>Your guess is too high!
    <br/>Current number of guesses: #{guess_counter}
    </pre>"
    responses[-1]
  end

  def correct_guess
    @guess == number
  end

  def correct_guess_response
    responses << "<pre>
    <br/>You guessed correctly!
    <br/>It took you this many tries: #{guess_counter}
    </pre>"
    reset_variables
    responses[-1]
  end

end