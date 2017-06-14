# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

require 'rack/reverse_proxy'

use Rack::ReverseProxy do
  reverse_proxy /^\/$/, 'http://0.0.0.0:4567'
  reverse_proxy /^\/login$/, 'http://0.0.0.0:4567'
  reverse_proxy /^\/docs\/.*$/, 'http://0.0.0.0:4567'
end
