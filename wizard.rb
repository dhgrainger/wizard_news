require 'sinatra'
require 'CSV'
require 'shotgun'
require 'pry'
require_relative'article_class.rb'


articles =[]

def read(file, articles)
CSV.foreach(file, headers: true) do |row|
	articles << row.to_hash
end
articles
end

read('article.csv', articles)
post '/article' do
	article = WizardArticle.new(params['title'], params['url'], params['article'])
	article.write('article.csv')
	articles = []
	read('article.csv', articles)
	redirect '/'
end

get '/' do
   @articles = articles
   erb :index
end
