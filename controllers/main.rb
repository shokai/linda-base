io = Sinatra::RocketIO
linda = Sinatra::RocketIO::Linda

io.on :connect do |client|
  $logger.info "new client - #{client}"
end

io.on :disconnect do |client|
  $logger.info "disconnect client - #{client}"
end

linda.on :* do |event, tuple, client|
  $logger.info "#{event} #{tuple.tuple} in <#{tuple.space}> by <#{client}>"
end

get '/' do
  @user = user_info
  haml :index
end

get '/*.css' do |path|
  scss path.to_sym
end

get '/*' do |path|
  @user = user_info
  @arr = path.split("/")
  @space = @arr.shift
  haml :tuple
end

post %r{^/([^/]+)\.write$} do |space|
  tuple = JSON.parse params[:tuple] rescue halt 400, "invalid tuple"
  halt 400, "invalid space name" if !space or space.empty?
  response["Access-Control-Allow-Origin"] = "*"
  $logger.info "linda[#{space}].write #{tuple}"
  linda[space].write tuple
  "linda[#{space}].write #{tuple}"
end
