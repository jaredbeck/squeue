require 'sinatra'

# use `Array` because `Queue` does not allow us to
# "peek", ie. view without popping
q = Array.new
lock = false

post '/q' do
  request.body.rewind # in case someone already read it
  # TODO: check content length and refuse giant bodies
  q.push request.body.read
  201
end

get '/q' do
  if q.length == 0
    [404, 'empty']
  elsif lock
    [409, 'locked']
  else
    lock = true
    [200, q.first]
  end
end

delete '/q' do
  if q.length == 0
    [404, 'empty']
  else
    q.shift
    lock = false
    204
  end
end

