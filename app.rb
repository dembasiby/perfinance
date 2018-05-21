require 'sinatra/base'

class Perfinance < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'secret'
  end

  before do
    session[:expenses] ||= []
    session[:revenues] ||= []
  end

  get '/' do
    redirect '/expenses'
  end

  get '/expenses' do
    @expenses = session[:expenses]
    erb :expenses
  end

  get '/expenses/new' do
    erb :new_expense
  end

  post '/expenses/new' do
    date = params[:date]
    description = params[:description]
    amount = params[:amount].to_i

    session[:expenses] << { date: date, description: description, amount: amount }
    redirect '/expenses'
  end

  get '/revenues' do
    @revenues = session[:revenues]
    @total = @revenues.reduce(0) { |sum, i| sum + i[:amount] }
    erb :revenues
  end

  get '/revenues/new' do
    erb :new_revenue
  end

  post '/revenues/new' do
    date = params[:date]
    description = params[:description]
    amount = params[:amount].to_i

    session[:revenues] << { date: date, description: description, amount: amount }
    redirect '/revenues'
  end

  get '/about' do
    erb :about
  end

  get '/clear' do
    session.clear
    redirect '/expenses'
  end
end
