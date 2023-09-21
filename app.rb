require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'sinatra/flash'

require_relative 'models/book'
require_relative 'models/review'
require_relative 'models/user'

configure do
  enable :sessions
  register Sinatra::Flash # configure sinatra-flash
end

get "/" do
  erb :index
end

post '/add-book' do
  @book = Book.create(title: params[:title], author: params[:author], description: params[:description])

  if @book.save
    erb :book
  else
    erb :index
  end
end

get '/book/:id' do
  @book = Book.find(params[:id])
  erb :book
end

get '/books' do
  @books = Book.order(created_at: :asc)
  erb :books
end

get '/books/edit/:id' do
  @book = Book.find(params[:id])
  erb :edit_book
end

post '/update-book/:id' do
  @book = Book.find(params[:id])
  @book.update(title: params[:title], author: params[:author], description: params[:description])
  erb :book
end

get '/register' do
  erb :register
end

post '/register' do
  @user = User.create(
    username: params[:username],
    password: params[:password]
    )

    if @user.save
      redirect '/login'
    else
      erb :register
    end
  end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by(username: params[:username])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/books'
  else
    flash[:error] = "Invalid username or password" # Set flash error message
    erb :login
  end
end

def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end
