# config.ru
require './app' # This loads your Sinatra application defined in app.rb

# Specify the application to run
run Sinatra::Application
