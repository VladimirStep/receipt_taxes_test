require_relative 'support/load_data'
require_relative 'support/cli_process'

include LoadData

RSpec.configure do |config|
  config.color = true
end