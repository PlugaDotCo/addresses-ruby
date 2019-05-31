module Address
  module Io
    class Addresses
      include ApiResource
      include ApiOperations::Retrieve

      BASE_URL = 'http://address.api.nfe.io'

      def self.url
        '/v2/addresses'
      end

      def url
        "#{self.class.url}/#{self.id}"
      end

      def self.api_request(url, method, params = nil)
        address = super(url, method, params)

        if address.is_a?(Hash)
          format_address(address[:address])
        else
          legacy_url = 'http://open.nfe.io/v1/addresses'
          super(legacy_url, method, params)
        end
      rescue
        'The resource you are looking for has been removed, had its name changed, or is temporarily unavailable.'
      end

      def self.format_address(address)
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
      end
    end
  end
end
