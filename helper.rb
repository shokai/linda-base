helpers do
  def app_name
    "linda-base"
  end

  def app_root
    "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}"
  end

  def error_and_back(err)
    session[:error] = err.to_s
    redirect '/'
  end

  def error?
    err = session[:error]
    session[:error] = nil
    return err
  end
end
