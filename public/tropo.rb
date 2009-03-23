require 'uri'
require 'open-uri'

def command c
  c = URI.encode c
  open "http://frotz.jankyteeth.com/?save=#{$currentCall.callerID}&command=#{c}" { |f| f.read }
end

answer
wait 1000

say command('look')

hangup
