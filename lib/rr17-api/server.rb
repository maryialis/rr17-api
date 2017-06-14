require 'sinatra'
require 'json'
require 'yaml'
require './auth.rb'

$auth_secret

configure :development do
  $auth_secret = YAML.load_file('../../config/secrets.yml')['development']['secret_key_base']
end

configure :test do
  $auth_secret = YAML.load_file('../../config/secrets.yml')['test']['secret_key_base']
end

get '/' do
  content_type :json
  { provider: 'rr17-api', version: '1' }.to_json
end

get %r{/docs/.*} do
  send_file '../../data/docs.html'
end

post '/login' do
  @body = JSON.parse(request.body.read)
  @jwt = Auth.new($auth_secret).issue({ email: @body['auth']['email'], password: @body['auth']['password'] })
  content_type :json
  { jwt: @jwt }.to_json
end
