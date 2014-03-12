require 'sinatra'
require 'CSV'
require 'shotgun'
require 'pry'
require_relative'article_class.rb'


def read(file)
  articles = Hash.new
  CSV.foreach(file, headers: true) do |row|
  	rows = row.to_hash
  	articles.store(rows["url"], {title: rows["title"], article: rows["article"]})
  end
  articles
end



post '/article' do
	article = WizardArticle.new(params['title'], params['url'], params['article'])
	article.write('article.csv')
	articles = read('article.csv')
	redirect '/'
end

get '/' do
   @articles = read('article.csv')
   erb :index
end

# articles = read('article.csv')
get '/:url' do
  @articles = read('article.csv')
  @header = @articles[params[:url]][:title]
  @article = @articles[params[:url]][:article]
  erb :wizard_news
end

#  articles.each do |title, hash|
#   get "/#{URI::encode(hash[:url])}" do
#     @header = title
#     @article = hash[:article]
#     erb :wizard_news
#   end
# end
