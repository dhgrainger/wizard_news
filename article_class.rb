require'CSV'

class WizardArticle
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

	
end