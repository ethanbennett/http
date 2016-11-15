require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'
require 'faraday'

class ParserTest < Minitest::Test

  def setup
    request_lines = ["GET /datetime HTTP/1.1\r\n",
      "Host: localhost:9292\r\n",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:49.0) Gecko/20100101 Firefox/49.0\r\n",
      "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\n",
      "Accept-Language: en-US,en;q=0.5\r\n",
      "Accept-Encoding: gzip, deflate\r\n",
      "Connection: keep-alive\r\n",
      "Upgrade-Insecure-Requests: 1\r\n"]
    @parser = Parser.new([], request_lines)
  end

  def test_parser_receives_full_request
    assert_equal 8, @parser.full_request.size
  end

  def test_parser_parses_host
    assert_equal "localhost:9292", @parser.host
  end

  def test_parser_parses_verb
    assert_equal "GET", @parser.verb
  end

  def test_parser_parses_path
    assert_equal "/datetime", @parser.path
  end

  def test_parser_parses_protocol
    assert_equal "HTTP/1.1", @parser.protocol
  end

  def test_parser_parses_accept
    assert_equal (["Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\n",
    "Accept-Language: en-US,en;q=0.5\r\n",
    "Accept-Encoding: gzip, deflate\r\n"]), @parser.accept
  end

  def parser_can_find_unparsed_guesses
    assert_equal 8, @parser.guess
  end

end