class Parser
  attr_reader   :host,    :verb,
                :path,    :protocol,
                :accept 

  def initialize(request_lines)
    # require 'pry'; binding.pry
    @host          = request_lines[1].split(" ")[1]
    @verb          = request_lines[0].split(" ")[0]
    @path          = request_lines[0].split(" ")[1]
    @protocol      = request_lines[0].split(" ")[2]
    @accept        = request_lines[3..5]

  end

  def paths
    if path == "/hello"
      special = "Hello, world!"
    elsif path == "/"
      special = nil
    elsif path == "/datetime"
      special = Time.now.strftime('%I:%M %p on %A, %b %d, %Y')
    elsif path == "shutdown"
      
    end
  end
end