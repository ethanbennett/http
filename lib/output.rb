class Output
  attr_reader   :client,
                :parser,
                :request_lines

  def initialize(client, parser, request_lines)
    @client        = client
    @parser        = parser
    @request_lines =  request_lines
  end
  
  def response
    response = "<pre>" + request_lines.join("\n") + "</pre>"
    output = "<html><head></head><h1>#{parser.paths}</h1><body>#{response}</body></html>
      <pre>
      Verb: #{parser.verb}
      Path: #{parser.path}
      Protocol: #{parser.protocol}
      Host: #{parser.host}
      Port: 9292
      Origin: localhost
      Accept: #{parser.accept}
      </pre>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
  end

end