require 'bundler'
Bundler.require
require 'sinatra/base'

require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    erb :gossip_with_index, locals: {gossip: Gossip.find(params['id'].to_i)}
  end

  get '/gossips/edit/:id/' do
    erb :gossip_edit, locals: {edit: Gossip.edit(params['id'].to_i)}
  end
  
  post '/gossips/edit/:id/' do
    Gossip.update(params['id'].to_i, params["new_gossip_content"])
    redirect '/'
  end

end

