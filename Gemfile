source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

gem "rails", "~> 6.0.2", ">= 6.0.2.1"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 4.1"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "rubocop", "~> 0.79.0", require: false
gem "bcrypt", "~> 3.1.11"

gem "faker"
gem "config"
gem "carrierwave", "~> 2.1.0"
gem "mini_magick", "~> 4.3"
gem "kaminari", "~> 1.2"
gem "bootstrap-kaminari-views"
gem "i18n-js"

gem "bootstrap-sass", "~> 3.3", ">= 3.3.7"
gem "font-awesome-rails", "~> 4.7", ">= 4.7.0.4"
gem "jquery-rails"
gem "jquery-ui-rails", "~> 6.0", ">= 6.0.1"

gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "pg"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
