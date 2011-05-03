require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'sequel'

DB = Sequel.mysql 'cerberus_prox', 
                   :user => '', 
                   :password => '',
                   :host => ''

get '/' do
  @cards = DB[:card]
  erb :card_holders
end

get '/cardholder/new' do
  erb :new_card_holder
end

post '/cardholder/new' do
  params[:expires] = Time.now
  params[:valid_from] = Time.now
  params[:disabled] = 'Y'
  DB[:card].insert(params)
  redirect '/'
end

get '/cardholder/delete/:id' do
  DB[:card].filter(:card_id => params[:id]).delete
  redirect '/'
end
