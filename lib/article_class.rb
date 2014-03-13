require'CSV'

class WizardArticle
	attr_reader :title, :url, :article
	def initialize(title, url, article)
		@title = title
		@url = url
		@article = article
	end

	def write(file)
		unless File.exists?(file)
			CSV.open(file, 'ab'){|csv| csv << ["title", "url", "article"]}
		end

		CSV.open(file, 'ab') do |csv|
			csv << [@title, @url, @article]
		end
	end

	def self.read(file)
	  articles = Hash.new
	  CSV.foreach(file, headers: true) do |row|
	  	articles.store(row["url"], {title: row["title"], article: row["article"]})
	  end
	  articles
	end
end
