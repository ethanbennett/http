require 'pry'

class Output
  attr_reader   :client,    :parser,
                :verb,      :path,
                :protocol,  :host,
                :accept,    :message,
                :output,    :response_code,
                :server

  def initialize(client, parser, server)
    @server        = server
    @client        = client
    @parser        = parser
    @verb          = parser.verb
    @path          = parser.path
    @protocol      = parser.protocol
    @host          = parser.host
    @accept        = parser.accept
    @message       = parser.paths
    @output        = output_string
    @response_code = select_response_code
  end

  def response
    client.puts select_header
    client.puts output
    if server.looper.eql?(false)
      client.shutdown
    end
  end

  def select_header
    if path.eql?("/start_game") && server.game_started.eql?(false)
      redirect_header
    else
      normal_header
    end
  end

  def normal_header
    ["http/1.1 #{response_code}",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def redirect_header
    ["HTTP/1.1 302 Redirect",
    "Location: http://localhost:9292/game ",
    "Content-Type: text/html; charset=iso-8859-1",
    "Server: ruby",
    "Date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "Connection: close"].join("\r\n")
  end

  def select_response_code
    if path.eql?("/start_game")
      "403 Forbidden"
    elsif message.include?("500")
      "500 Internal Server Error"
    elsif message.include?("404")
      "404 Not Found"
    else
      "200 ok"
    end
  end

  def output_string
    "<html><head></head><h1>#{message}</h1></html>
    <pre>
    Verb: #{verb}
    Path: #{path}
    Protocol: #{protocol}
    Host: #{host}
    Port: 9292
    Origin: localhost
    Accept: #{accept}
    </pre>"
  end

end