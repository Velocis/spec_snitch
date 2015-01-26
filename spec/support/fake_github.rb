require 'sinatra/base'

class FakeGithub < Sinatra::Base
  get '/repos/*/issues' do
    status 200, 'hello world!'
  end
end
