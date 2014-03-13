require 'sinatra'
require 'CSV'
require 'shotgun'
require 'pry'
require_relative'article_class.rb'
file = '../article.csv'

post '/article' do
	article = WizardArticle.new(params['title'], params['url'], params['article'])
	article.write(file)
	articles = WizardArticle.read(file)
	redirect '/'
end

get '/' do
  @articles = WizardArticle.read(file)
  erb :index
end

get '/:url' do
  @articles = WizardArticle.read(file)
  @header = @articles[params[:url]][:title]
  @article = @articles[params[:url]][:article]
  erb :wizard_news
end


