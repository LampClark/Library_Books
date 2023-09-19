require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/book'

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
