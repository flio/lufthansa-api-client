source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in lufthansa.gemspec
gemspec

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'growl'
  gem 'byebug'
  gem 'webmock'
end

group :test do
  gem 'vcr'
  gem 'byebug'
end
