require 'json'

set :server, 'thin'
set :sockets, []

get '/' do
  haml :index
end
