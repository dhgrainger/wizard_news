require 'sinatra'
require 'CSV'
require 'shotgun'
require 'pry'
require_relative'article_class.rb'


articles = Hash.new

def read(file, articles)
CSV.foreach(file, headers: true) do |row|
	rows = row.to_hash
	articles.store(row["title"], {url: rows["url"], article: rows["article"]})
end
articles
end

read('article.csv', articles)

post '/article' do
	article = WizardArticle.new(params['title'], params['url'], params['article'])
	article.write('article.csv')
	articles = {}
	read('article.csv', articles)
	redirect '/'
end

get '/' do
   @articles = articles
   erb :index
end

 articles.each do |title, hash|
  get "/#{URI::encode(hash[:url])}" do
    @header = title
    @article = hash[:article]
    erb :wizard_news
  end
end