require 'sinatra'

get '/' do
  erb :index
end

get '/welcome' do
  @name = params[:name]
  erb :welcome
end
