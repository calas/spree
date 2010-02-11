# bundle_path "vendor/bundler_gems"

source :gemcutter

group :rails do
  gem 'rails', '~> 2.3.5', :require => nil
  gem 'builder', '~> 2.1.2'
  gem 'memcache-client', '>= 1.7.4', :require => nil
  gem 'tzinfo', '~> 0.3.12'
  gem 'i18n', '>= 0.1.3'
  gem 'tmail', '~> 1.2.3'
  gem 'text-format', '>= 0.6.3', :require => 'text/format'
end

gem "activemerchant", "1.5.0", :require => "active_merchant"
gem "activerecord-tableless", "0.1.0", :require => "tableless"
gem "authlogic", ">=2.1.2"
gem "authlogic-oid", "1.0.4", :require => "authlogic_openid"
gem "chronic", "0.2.3"
gem "faker", "0.3.1"
gem "highline", "1.5.1"
gem "less", "1.2.20"
gem "paperclip", ">=2.3.1.1"
gem "searchlogic", "2.3.5"
gem "state_machine", "0.8.0"
gem "stringex", "1.0.3"
gem "whenever", "0.3.7", :require => nil
gem "will_paginate", "2.3.11"

group :test do
  gem "shoulda", "2.10.2"
  gem "factory_girl", "1.2.3"
end

Dir.glob(File.expand_path("../vendor/extensions/**/Gemfile", __FILE__)).each do |ext|
  puts "=> Loading #{ext}"
  instance_eval(File.read(ext), ext)
end

development_gemfile = File.expand_path("../Gemfile.development", __FILE__)
if File.exists?(development_gemfile)
  instance_eval(File.read(development_gemfile), development_gemfile)
end
