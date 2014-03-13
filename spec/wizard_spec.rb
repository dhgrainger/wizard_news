require 'rspec'
require_relative '../lib/wizard.rb'

describe WizardArticle do
  let(:title) { 'wizard' }
  let(:url) { 'www.wizard.com' }
  let(:article) { 'wizards are horrible this year' }
  let(:wizard) {WizardArticle.new(title, url, article)}

    it 'has a name' do
      expect(wizard.title).to eq(title)
    end

     it 'has a url' do
      expect(wizard.url).to eq(url)
    end

     it 'has a article' do
      expect(wizard.article).to eq(article)
    end

    context 'working with files' do
      let(:test_file) { "test_file.csv" }

      after(:each) do
        FileUtils.rm_f(test_file)
      end

      it 'writes header to a csv file if it does not exist' do
        wizard.write(test_file)

        lines = []
        CSV.foreach(test_file) do |csv|
          lines << csv
        end
        expect(lines[0][0]).to eq("title")
      end

      it 'writes values to the csv' do
        wizard.write(test_file)

        articles = []
        CSV.foreach(test_file) do |csv|
          articles << csv
        end

        expect(articles[1][0]).to eq('wizard')
      end

    end
end


