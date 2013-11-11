runner = LindaBase::CodeRunner.new
p runner.workers
runner.run "test"

p runner.workers

get '/code/:id' do |code_id|
  @code = Hashie::Mash.new(:id => code_id)
  haml :run_code
end
