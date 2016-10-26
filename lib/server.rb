require 'socket'
require_relative 'parser'

tcp_server = TCPServer.new(9292)
client = tcp_server.accept
counter = 0

puts "Ready for a request"
@request_lines = []
while line = client.gets and !line.chomp.empty?
  @request_lines << line.chomp
  counter += 1
end

parser = Parser.new(@request_lines)
  if parser.path == "/hello"
    special = "Hello, world! (#{counter})"
  elsif parser.path == "/"
    special = nil
  elsif parser.path == "/datetime"
    special = Time.now.strftime('%I:%M %p on %A, %b %d, %Y')
  elsif parser.path == "shutdown"
    special = counter
  end

puts "Got this request:"
puts @request_lines.inspect

puts "Sending response."
response = "<pre>" + @request_lines.join("\n") + "</pre>"
output = "<html><head></head><h1>#{special}</h1><body>#{response}</body></html>
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

puts ["Wrote this response:", headers, output].join("\n")
client.close
puts "\nResponse complete, exiting."

if __FILE__ == $0
server = WebServer.new
server.server_loop
end