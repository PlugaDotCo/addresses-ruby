module Address
  module Io
    class Addresses
      include ApiResource
      include ApiOperations::Retrieve

      BASE_URL = 'http://address.api.nfe.io'

      def self.url
        "/v2/addresses"
      end

      def url
        "#{self.class.url}/#{self.id}"
      end

      def self.api_request(url, method, params=nil)
        address = super(url, method, params)[:address]
        {
          postalCode: address[:postalCode],
          streetSuffix: address[:streetSuffix],
          street: address[:street],
          district: address[:district],
          city: {
            code: address[:city][:code],
            name: address[:city][:name]
          },
          state: {
            abbreviation: address[:state]
          }
        }
      rescue
        'The resource you are looking for has been removed, had its name changed, or is temporarily unavailable.'
      end
    end
  end
end
