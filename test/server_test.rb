require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class ServerTest < Minitest::Test

  def test_server_gets_200_response
    response = Faraday.get("http://localhost:9292/")
    assert_equal 200, response.status
  end


  def test_hello_path_outputs_proper_message
    response = Faraday.get("http://localhost:9292/hello")
    parser = Parser.new(response.body, nil)
    assert_equal true, response.body.include?("Hello, world!")
  end

  def test_datetime_outputs_proper_message
    response = Faraday.get("http://localhost:9292/datetime")
    parser = Parser.new(response.body, nil)
    # require 'pry'; binding.pry
    assert_equal true, response.body.include?("Oct") && response.body.include?("2016")
  end

end