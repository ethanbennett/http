class Game
  attr_reader   :number,
                :path

  def initialize(number, path)
    @number = number
    @path   = path
  end

  def play
    if guess >  number
      too_high
    elsif guess <  number
      too_low
    elsif guess == number
      nice_job
    else
      "Uhh...what?"
    end
  end

  def guess
    path.split("?")[1].split("=")[1].to_i
  end

  def too_high
    "Sorry, your guess was too high. Try again."
  end

  def too_low
    "Sorry, your guess was too low. Try again."
  end

  def nice_job
    "You got it! Seems like a waste of time, but nice job. Go to \"/shutdown\" and reload the page if you want to play again."
  end
end
