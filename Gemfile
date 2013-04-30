source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'thin'

# Database
group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sqlite3'
  gem "better_errors", ">= 0.3.2"
  gem 'quiet_assets'
end

# Enumerated attributes gem from Github repo
gem 'enumerated_attribute', :git => 'git://github.com/jeffp/enumerated_attribute.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem "figaro"
gem "paperclip", "~> 3.0"