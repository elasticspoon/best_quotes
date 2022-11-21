require './config/application'
require 'rack/lobster'
require 'rack/builder'
require 'rack-google-analytics'

# puts  $LOAD_PATH
# puts File.exists?('rack-tracker')

# run proc {
#   [200, {'content-type' => 'text/html'}, ['Hello from Rack!']]
# }

# obj = Object.new
# def obj.call(*args)
#   [200, {'content-type' => 'text/html'}, ['Hello from Rack!']]
# end
# run obj

# INNER_LAYER = proc {
#   'world!'
# }

# OUTER_LAYER = proc {
#   inner_content = INNER_LAYER.call
#   [200, {'content-type' => 'text/html'}, ["Hello #{inner_content}"]]
# }
# run OUTER_LAYER

# use Rack::Auth::Basic, 'app' do | _, pass |
#   'secret' == pass
# end

# class Canadianize
#   def initialize(app, arg = '')
#     @app = app
#     @arg = arg
#   end
  
#   def call(env)
#     status, headers, body = @app.call(env)
#     body[0] += @arg + ', eh?'
#     [status, headers, body]
#   end
# end
  
# use Canadianize, ', simple'

# run proc {
#   [200, {'content-type' => 'text/html'}, ['Hello from Rack!']]
# }


# require 'rack/lobster'
# use Rack::ContentType

# map '/lobster/but_not' do
#   run proc {
#     [200, {}, ['Really not a lobster']]
#   }
# end

# map '/lobster' do
#   use Rack::ShowExceptions
#   run Rack::Lobster.new
# end

# run proc {
#   [200, {}, ['Not a lobster']]
# }


# use Rack::ContentType

# module Rack
#   class GoogleAnalytics
#     private

#     def html?
#       @headers['Content-Type'] =~ /html/ || @headers['content-type'] =~ /html/
#     end
#   end

# end

# # use Rack::GoogleAnalytics, :tracker => ->() { puts 'this got ran'}
# use Rack::GoogleAnalytics, :tracker => 'UA-249502138-1'

# class BenchMarker
#   def initialize(app, runs = 100)
#     @app = app
#     @runs = runs
#   end

#   def call(env)
#     start_time = Time.now

#     result = nil
#     @runs.times { result = @app.call(env) }

#     run_time = Time.now - start_time

#     STDERR.puts <<OUTPUT
#     Benchmark:
#     #{@runs} runs
#     #{run_time.to_f} seconds total
#     #{run_time.to_f * 1000.0 / @runs} millisconds per run
# OUTPUT

#     result
#   end
# end

# use BenchMarker, 10000

# run Rack::Lobster.new
app = BestQuotes::Application.new

use Rack::ContentType

app.route do
  # match '', 'quotes#index'
  match 'sub-app', 
    proc { [200, {}, ['Hello from sub-app']] }
  
    # default routes
  resources :quotes
    # match ':controller(/:action(/:id))'
  # match ':controller/:action'
  # match ':controller/:id', default: { 'action' => 'show' }
  # match ':controller', default: { 'action' => 'index' }
  root 'quotes#index'
end

run app