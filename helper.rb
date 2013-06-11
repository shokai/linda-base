require 'digest/md5'
require 'hashie'

helpers do
  def app_name
    "linda-base"
  end

  def app_root
    "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}"
  end

  def create_session_id
    Digest::MD5.hexdigest "#{rand 10000} #{Time.now.to_i} #{Time.now.usec}"
  end

  def user_info
    return nil unless session[:id]
    u = (@@auth_cache||=Cache.new("auth")).get session[:id]
    return nil unless u
    Hashie::Mash.new u
  end

  def logout
    return unless session[:id]
    (@@auth_cache||=Cache.new("auth")).delete session[:id]
    session[:id] = nil
  end
end
