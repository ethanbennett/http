class Parser
  attr_reader   :host,    :verb,
                :path,    :protocol,
                :accept,  :counter

  def initialize(request_lines, counter)
    # require 'pry'; binding.pry
    @host          = request_lines[1].split(" ")[1]
    @verb          = request_lines[0].split(" ")[0]
    @path          = request_lines[0].split(" ")[1]
    @protocol      = request_lines[0].split(" ")[2]
    @accept        = request_lines[3..5]
    @counter       = counter

  end

  def paths
    if path == "/hello"
      "Hello, world! #{counter}"
    elsif path == "/"
      "Gif embedded here"
    elsif path == "/datetime"
      Time.now.strftime('%I:%M %p on %A, %b %d, %Y')
    elsif path == "/shutdown"
      "#{counter}"
    else
      "404"  
    end
  end
end