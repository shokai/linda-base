require 'httparty'
require 'octokit'
require 'digest/md5'
require 'hashie'

helpers do
  def create_session_id
    Digest::MD5.hexdigest "#{rand 10000} #{Time.now.to_i} #{Time.now.usec}"
  end

  def user_info
    return nil unless session[:id]
    u = Cache["auth"].get session[:id]
    return nil unless u
    Hashie::Mash.new u
  end

  def logout
    return unless session[:id]
    Cache["auth"].delete session[:id]
    session[:id] = nil
  end
end

get '/logout' do
  logout
  redirect '/'
end

get '/auth' do
  logout
  query = {
    :client_id => ENV["GITHUB_APP_ID"],
    :redirect_uri => "#{app_root}/auth.callback",
  }.map{|k,v|
    "#{k}=#{URI.encode v}"
  }.join("&")
  redirect "https://github.com/login/oauth/authorize?#{query}"
end

get '/auth.callback' do
  code = params["code"]
  halt 400, "bad request (code)" if code.to_s.empty?
  query = {
    :body => {
      :client_id => ENV["GITHUB_APP_ID"],
      :client_secret => ENV["GITHUB_APP_SECRET"],
      :code => code
    },
    :headers => {
      "Accept" => "application/json"
    }
  }
  res = HTTParty.post("https://github.com/login/oauth/access_token", query)
  halt 500, "github auth error" unless res.code == 200
  begin
    token = JSON.parse(res.body)["access_token"]
    client = Octokit::Client.new :oauth_token => token
    user = client.user
  rescue => e
    halt 500, "github auth error"
  end
  session_id = create_session_id
  Cache["auth"].set session_id, {
    :oauth_token => token,
    :name => user.login,
    :id => user.id,
    :icon => user.avatar_url
  }
  session[:id] = session_id
  redirect '/'
end
