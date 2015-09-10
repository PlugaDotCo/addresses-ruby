require "rest-client"
require "json"
require "address/io/version"

require "address/io/api_resource"
require "address/io/api_operations/list"
require "address/io/api_operations/retrieve"
require "address/io/state"
require "address/io/city"
require "address/io/addresses"

module Address
  module Io
    @@api_key = ''

    def self.api_key(api_key)
      @@api_key = api_key
    end

    def self.access_keys
      "#{@@api_key}"
    end
  end
end
