module Address
  module Io
    class Addresses
      include ApiResource
      include ApiOperations::Retrieve
      def self.url
        "/v1/addresses"
      end

      def url
        "#{self.class.url}/#{self.id}"
      end
    end
  end
end