
io = Sinatra::RocketIO
linda = Sinatra::RocketIO::Linda

helpers do
  def app_name
    "linda-base"
  end
end

io.on :* do |event, data, client|
  puts "#{event} - #{data} <#{client}>"
end

get '/tuple/*' do
  @arr = params[:splat][0].split("/")
  @space_name = @arr.shift
  haml :tuple
end

get '/' do
  haml :index
end
