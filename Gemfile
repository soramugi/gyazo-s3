source 'https://rubygems.org'
ruby '2.1.1'

gem 'rails'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'paperclip', git: 'git://github.com/thoughtbot/paperclip.git'
gem 'aws-sdk'
gem 'kaminari'
gem 'nokogiri'

group :doc do
  gem 'sdoc', '~> 0.4.0'
end
group :development do
  gem 'spring'
end
group :development, :test do
  gem 'sqlite3'
end
group :test do
  gem 'simplecov', require: false
  gem 'coveralls', require: false
end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
