require 'rubygems'
require 'bundler'
require 'fakeweb'

Bundler.setup
require 'ptilinopus'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'

  config.before(:all) do
    FakeWeb.allow_net_connect = false
  end
end
