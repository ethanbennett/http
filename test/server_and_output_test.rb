require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class ServerTest < Minitest::Test

  def test_hello_path_outputs_proper_message
    response = Faraday.get("http://localhost:9292/hello")
    assert response.body.include?("Hello, world!")
  end

  def test_datetime_outputs_proper_message
    response = Faraday.get("http://localhost:9292/datetime")
    assert response.body.include?(Time.now.strftime('%I:%M %p on %A, %b %d, %Y'))
  end

  def test_shutdown_displays_count
    skip
    response = Faraday.get("http://localhost:9292/shutdown")
    assert response.body.include?("Count:")
  end

  def test_error_message_displays
    response = Faraday.get("http://localhost:9292/checkout-how-thorough-these-tests-are")
    assert response.body.include?("404")
  end

  def test_word_search_outputs_proper_message
    response   = Faraday.get("http://localhost:9292/wordsearch?word=word")
    response_2 = Faraday.get("http://localhost:9292/wordsearch?word=wor")
    assert response.body.include?("WORD is a known word")
    assert response_2.body.include?("WOR is not a known word")
  end

  def test_start_game_only_starts_one_game
    response = Faraday.get("http://localhost:9292/game")
    response_2 = Faraday.get("http://localhost:9292/start_game")
    assert response_2.body.include?("403")
  end

  
end