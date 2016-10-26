class Output
  attr_reader   :client,
                :parser

  def initialize(client, parser)
    @client        = client
    @parser        = parser
  end

  def response_strings
    output = "<html><head></head><h1>#{parser.paths}</h1></html>
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
    response(headers, output)
  end

  def response(headers, output)
    client.puts headers
    client.puts output
  end

end