module GameSetup

  # def counter
  #   if @guess_counter.eql? nil
  #     @guess_counter = 1
  #   else
  #     @guess_counter += 1
  #   end
  # end

  def increase_count
    parser.server.game_counter += 1
  end

  def current_number_of_guesses
    "<pre>Current number of guesses: #{guess_counter}</pre>"
  end

  end