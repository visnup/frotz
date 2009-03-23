require 'uri'
require 'net/http'

class Frotz
  def type c
    c = URI.encode c
    url = "http://frotz.jankyteeth.com/?save=#{$currentCall.callerID}&command=#{c}" 
    Net::HTTP.get_response(URI.parse(url)).body
  end
end

answer
wait 1000

f = Frotz.new
say f.type('look')

while true  r = ask "what do you want to do?", :choices => 'look, open, close, open mailbox, read, east, west, north, south'
  if r.name == 'choice'
    say f.type(r.value)
  end
end

hangup
