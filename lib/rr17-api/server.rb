require 'sinatra'
require 'json'
require 'yaml'
require './auth.rb'

SECRETS_FILE = File.join(Rails.root, 'config', 'secrets.yml')

configure :development do
  AUTH_SECRET = YAML.load_file(SECRETS_FILE)['development']['secret_key_base']
end

configure :test do
  AUTH_SECRET = YAML.load_file(SECRETS_FILE)['test']['secret_key_base']
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
  @jwt = Auth.new(AUTH_SECRET).issue(
    email: @body['auth']['email'], password: @body['auth']['password']
  )
  content_type :json
  { jwt: @jwt }.to_json
end
