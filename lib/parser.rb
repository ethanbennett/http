require './lib/word_search'

class Parser

  attr_reader   :host,    :verb,
                :path,    :protocol,
                :accept,  :counter

  def initialize(request_lines, counter)
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
      "<iframe src=\"//giphy.com/embed/YfO8X3PfSmuyY\" width=\"240\" height=\"390\" frameBorder=\"0\" class=\"giphy-embed\" allowFullScreen></iframe><p><a href=\"http://giphy.com/gifs/paul-rudd-tim-and-eric-celery-man-YfO8X3PfSmuyY\"></a></p>Root!!!"
    elsif path == "/datetime"
      Time.now.strftime('%I:%M %p on %A, %b %d, %Y')
    elsif path == "/shutdown"
      "Count: #{counter}"
    elsif path.include?("/wordsearch")
      WordSearch.new(path).go
    else
      "<iframe src=\"//giphy.com/embed/TUc0ZkK15eiTC\" width=\"480\" height=\"270\" frameBorder=\"0\" class=\"giphy-embed\" allowFullScreen></iframe><p><a href=\"http://giphy.com/gifs/wtf-tim-and-eric-wut-TUc0ZkK15eiTC\"></a></p>404!!!"  
    end
  end
end