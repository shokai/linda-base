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

linda.on :* do |event, tuple, client|
  puts "#{event} #{tuple.tuple} in <#{tuple.space}> by <#{client}>"
end

get %r{^/([\w/]+)$} do |arr|
  @arr = arr.split("/")
  @space = @arr.shift
  haml :tuple
end

get '/' do
  haml :index
end

get '/*.css' do
  scss params[:splat][0].to_sym
end
