io = Sinatra::RocketIO
linda = Sinatra::RocketIO::Linda

helpers do
  def app_name
    "linda-base"
  end

  def app_root
    "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}"
  end
end

io.on :connect do |client|
  puts "new client - #{client}"
end

io.on :disconnect do |client|
  puts "disconnect client - #{client}"
end

linda.on :* do |event, tuple, client|
  puts "#{event} #{tuple.tuple} in <#{tuple.space}> by <#{client}>"
end

get '/' do
  haml :index
end

get '/*.css' do |path|
  scss path.to_sym
end

get '/*' do |path|
  @arr = path.split("/")
  @space = @arr.shift
  haml :tuple
end

