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

  def test_host_finder_finds_host
    assert_equal "localhost:9292", @parser.host_finder
  end

  def test_verb_finder_finds_verb
    assert_equal "GET", @parser.verb_finder
  end

  def test_path_finder_finds_path
    assert_equal "/datetime", @parser.path_finder
  end

  def test_protocol_finder_finds_protocol
    assert_equal "HTTP/1.1", @parser.protocol_finder
  end

  def test_accept_finder_finds_accept
    assert_equal (["Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\n",
    "Accept-Language: en-US,en;q=0.5\r\n",
    "Accept-Encoding: gzip, deflate\r\n"]), @parser.accept_finder
  end

  def guess_finder_finds_unparsed_guesses
    assert_equal 8, @parser.guess_finder
  end

  def test_root_message
    assert_equal "", @parser.root
  end

  def test_datetime_message
    assert_equal Time.now.strftime('%I:%M %p on %A, %b %d, %Y'), @parser.datetime
  end

  def test_forbidden_message
    assert @parser.forbidden.include?("403")
  end

  def test_system_error_message
    assert @parser.system_error.include?("500")
  end

  def test_unknown_message
    assert @parser.unknown.include?("404")
  end

  def test_generate_error_generates_error
    assert_equal String, @parser.generate_error.class
  end

end