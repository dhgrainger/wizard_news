require 'sinatra'
require 'CSV'
require 'shotgun'
require 'pry'
require_relative'article_class.rb'
file = '../article.csv'

def read(file)
  articles = Hash.new
  CSV.foreach(file, headers: true) do |row|
  	articles.store(row["url"], {title: row["title"], article: row["article"]})
  end
  articles
end

post '/article' do
	article = WizardArticle.new(params['title'], params['url'], params['article'])
	article.write(file)
	articles = read(file)
	redirect '/'
end

get '/' do
  @articles = read(file)
  erb :index
end

get '/:url' do
  @articles = read(file)
  @header = @articles[params[:url]][:title]
  @article = @articles[params[:url]][:article]
  erb :wizard_news
end


