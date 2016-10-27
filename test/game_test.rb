require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class GameTest < Minitest::Test

  def test_it_passes_a_path_in
    response = Faraday.get("http://localhost:9292/game?num=82")
    parser   = Parser.new(response.body, nil, 85)
    assert_equal true, response.body.include?("?")
  end

  def test_it_compares_numbers_accurately
    response = Faraday.get("http://localhost:9292/game?num=84")
    parser     = Parser.new(response.body, nil, 83)  
    assert_equal true, response.body.include?("too high.")
  end
end