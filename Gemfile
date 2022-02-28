# frozen_string_literal: true

source 'https://rubygems.org'
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

gem "active_interaction", "~> 4.1"
gem 'grape', '~> 1.3.0'
gem 'rails', '~> 7.0.0'
gem 'rspec-rails', '~> 3.8'

# gem 'tezos_client', '~> 1.4.2'
# gem "tezos_client", path: "../tezos_client/"
gem "tezos_client", git: "https://github.com/moneytrackio/tezos_client.git", branch: "feat/update-rails-version"
# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem 'bundler', '~> 2.2.14'
  gem 'juwelier', '~> 2.1.0'
  gem 'pry'
  #gem 'rdoc', '~> 3.12'
  # gem "rdoc", "~> 6.4"
  gem "faker", git: "https://github.com/moneytrackio/faker.git", branch: "feat/add-blockchain-tezos-keys"
end
