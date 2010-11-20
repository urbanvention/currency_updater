# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "currency_updater"
  s.version = "1.0.3"
  s.require_paths = ["lib"]
  s.files = [ "Gemfile",
              "Gemfile.lock",
              "README.markdown",
              "init.rb",
              "lib/currency_updater.rb",
              "lib/currency_updater/currencies.rb",
              "lib/currency_updater/currency.rb",
              "lib/currency_updater/updater.rb" ]
  s.description = "Updating currency rates made easy."
  s.summary     = "Updating currency rates made easy."
  s.required_ruby_version = ">= 1.8.7"
  s.test_files = [ "autotest/discover.rb",
                   "spec/spec_helper.rb",
                   "spec/currency_updater/currencies_spec.rb",
                   "spec/currency_updater/updater_spec.rb",
                   "remote_spec/remote_spec.rb" ]
  s.homepage = "http://github.com/urbanvention/currency_updater"
  s.email = "jan@urbanvention.com"
  s.date = "2010-11-20"
  s.authors = ["Jan Riethmayer"]
  s.rubygems_version = "1.3.6"
  s.add_dependency("iso_country_codes", "~> 0.2.2")
  s.add_dependency("yajl-ruby","~> 0.7.8")
  s.add_dependency("i18n",     "~> 0.4.2")
  s.add_dependency("builder",     "~> 2.1.2")
  s.add_dependency("actionpack", "~> 3.0.3")
end
