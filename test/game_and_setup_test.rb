require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    Struct.new("Parser", :verb, :guess)
    parser        = Struct::Parser.new("POST", 8)
    second_parser = Struct::Parser.new("GET", 8)
    @game         = Game.new(parser, 82, 1, [])
    @second_game  = Game.new(second_parser, 82, 1, [])
  end

  def test_current_number_of_guesses_displays_count
    assert @game.current_number_of_guesses.include?("Current number of guesses: 1")
  end

  def test_sort_by_verb_sorts_properly
    assert @second_game.sort_by_verb.include?("Current number of guesses: 1")
  end

  def test_low_guess_response
    assert @game.low_guess_response.include?("Your guess is too low!")
  end

  def test_high_guess_response
    assert @game.high_guess_response.include?("Your guess is too high!")
  end

  def test_game_knows_verb
    assert_equal "GET", @second_game.verb
    assert_equal "POST", @game.verb
  end

  def test_game_knows_number
    assert_equal 82, @game.number
  end

  def test_game_knows_counter
    assert_equal 8, @game.unparsed_guess
  end

  def assert_game_stores_responses_as_array
    assert_equal Array, @game.responses.class
  end

end
