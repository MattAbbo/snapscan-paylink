require 'sinatra'
require 'ruby-bulksms'
require 'byebug'
require 'json'

set :public_folder, File.dirname(__FILE__) + '/public'

use Rack::Auth::Basic do |username, password|
  username == 'mrdelivery' && password == 'order now'
end

get '/' do
    erb :index
end

post '/send_link' do
    json_request =  JSON.parse(request.body.read.to_s)
    client_number = json_request["client_number"]
    paylink = json_request["paylink"]

    service = Net::SMS::BulkSMS::Service.new('xxx', 'xxx', 'safrica')
    result = service.send(paylink, client_number)
    debugger

    "#{client_number} --- #{paylink}"
end
